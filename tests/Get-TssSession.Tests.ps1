BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName Unit Tests" {
    BeforeDiscovery {
        [object[]]$knownParameters = $null
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($CommandName, 'Function')).Parameters.Keys
        # $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
    }
    Context "Verify parameters" -Foreach @{currentParams = $currentParams} {
        It "$commandName should contain <_> parameter" -TestCases $knownParameters {
            $_ -in $currentParams | Should -Be $true
        }
        It "$commandName should not contain parameter: <_>" -TestCases $unknownParameters -Skip {
            $_ | Should -BeNullOrEmpty
        }
    }
}

Describe "$commandName returns the object" {
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
            New-TssSession -SecretServer $secretServer -Credential $cred > $null
            $session = Get-TssSession
        }
        It "Is PSCustomObject type" {
            $session.GetType().Name | Should -Be 'PSCustomObject'
        }
        It "Should have AccessToken as minimum (object testing is in test for New-TssSession)" {
            $session.AccessToken | Should -Not -BeNullOrEmpty
        }
    }
}