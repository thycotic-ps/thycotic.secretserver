BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'SecretServer', 'Credential', 'AccessToken', 'UseRefreshToken', 'RefreshLimit', 'AutoReconnect', 'Raw'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($CommandName, 'Function')).Parameters.Keys
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
    }
    Context "Verify parameters" -Foreach @{currentParams = $currentParams} {
        It "$commandName should contain <_> parameter" -TestCases $knownParameters {
            $_ -in $currentParams | Should -Be $true
        }
        It "$commandName should not contain parameter: <_>" -TestCases $unknownParameters {
            $_ | Should -BeNullOrEmpty
        }
    }
}

Describe "$commandName updates session object" {
    Context "Oauth2 authentication" {
        BeforeEach {
            $expiresIn = 1199
            [uri]$secretServer = 'https://alpha'
            $apiV = 'api/v1'
            Mock Invoke-RestMethod {
                @{
                    access_token = [System.Convert]::ToBase64String((New-Guid).ToByteArray())
                    token_type = 'bearer'
                    expires_in = $expiresIn
                    refresh_token = [System.Convert]::ToBase64String((New-Guid).ToByteArray())
                }
            }
            $cred = [pscredential]::new('user',(ConvertTo-SecureString "p" -AsPlainText -Force))
            $session = New-TssSession -SecretServer $secretServer -Credential $cred
        }
        It "Populates SecretServerUrl Propety" {
            $session.SecretServerUrl | Should -Be $secretServer
        }
        It "ApiVersion Propety is set" {
            $session.ApiVersion | Should -Be $apiV
        }
        It "Populates AccessToken Property" {
            $session.AccessToken | Should -Not -BeNullOrEmpty
        }
        It "Populates RefreshToken Property" {
            $session.RefreshToken | Should -Not -BeNullOrEmpty
        }
        It "Calculates TimeOfDeath" {
            $expectedValue = [datetime]::UtcNow.Add([timespan]::FromSeconds($expiresIn))
            $session.TimeOfDeath | Should -BeLessOrEqual $expectedValue
        }
        It "Calculates StartTime" {
            $currentTime = [datetime]::UtcNow
            $session.StartTime | Should -BeLessOrEqual $currentTime
        }
    }
}