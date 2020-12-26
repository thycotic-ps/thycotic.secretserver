BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'SecretServer', 'Credential', 'AccessToken', 'Raw'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName, 'Function')).Parameters.Keys
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
            [uri]$secretServer = $ss
            $apiV = 'api/v1'
            $session = New-TssSession -SecretServer $secretServer -Credential $ssCred
        }
        It "Populates SecretServer Propety" {
            $session.SecretServer | Should -Be $secretServer
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
        It "RefreshSession() method updates AccessToken" {
            $orgAccessToken = $session.AccessToken
            $session.SessionRefresh() | Should -Be $true
            $session.AccessToken | Should -Not -Match $orgAccessToken
        }
        It "SessionExpire() method should return true" {
            $session.SessionExpire() | Should -Be $true
        }
    }
}