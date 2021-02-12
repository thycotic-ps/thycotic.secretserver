BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'SecretServer', 'Credential', 'AccessToken'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName, 'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
    }
    Context "Verify parameters" -ForEach @{currentParams = $currentParams } {
        It "$commandName should contain <_> parameter" -TestCases $knownParameters {
            $_ -in $currentParams | Should -Be $true
        }
        It "$commandName should not contain parameter: <_>" -TestCases $unknownParameters {
            $_ | Should -BeNullOrEmpty
        }
    }
    Context "Command specific details" {
        It "$commandName should set OutputType to TssSession" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'TssSession'
        }
    }
}

Describe "$commandName works" {
    BeforeAll {
        $apiV = 'api/v1'
        $sessionCredential = New-TssSession -SecretServer $ss -Credential $ssCred

        $secretServerHost = 'https://tenant.secretservercloud.com'
        $generatedAccessToken = (New-Guid).Guid
        $sessionAccessToken = New-TssSession -SecretServer $secretServerHost -AccessToken $generatedAccessToken

        $hostnameSampleFile = ([IO.Path]::Combine([string]$PSScriptRoot, '..\test_data', 'newsession_hostsamples.txt'))
        $hostnameSamples = Get-Content $hostnameSampleFile
    }
    Context "Validates SecretServer argument" {
        It "Should catch invalid URL arguments" {
            { New-TssSession -SecretServer 'https://alpha/api/v1' -AccessToken "$(Get-Random)" } | Should -Throw
        }
    }
    Context "Credential parameter" {
        It "Populates SecretServer Property" {
            $sessionCredential.SecretServer | Should -Be ([uri]$ss)
        }
        It "ApiVersion Property is set" {
            $sessionCredential.ApiVersion | Should -Be $apiV
        }
        It "ApiUrl Property is set" {
            $sessionCredential.ApiUrl | Should -Not -BeNullOrEmpty
        }
        It "Populates AccessToken Property" {
            $sessionCredential.AccessToken | Should -Not -BeNullOrEmpty
        }
        It "Populates RefreshToken Property" {
            $sessionCredential.RefreshToken | Should -Not -BeNullOrEmpty
        }
        It "Calculates TimeOfDeath" {
            $expectedValue = [datetime]::UtcNow.Add([timespan]::FromSeconds($expiresIn))
            $sessionCredential.TimeOfDeath | Should -BeLessOrEqual $expectedValue
        }
        It "Calculates StartTime" {
            $currentTime = [datetime]::UtcNow
            $sessionCredential.StartTime | Should -BeLessOrEqual $currentTime
        }
        It "RefreshSession() method updates AccessToken" {
            $orgAccessToken = $sessionCredential.AccessToken
            $sessionCredential.SessionRefresh() | Should -Be $true
            $sessionCredential.AccessToken | Should -Not -Match $orgAccessToken
        }
        It "SessionExpire() method should return true" {
            $sessionCredential.SessionExpire() | Should -Be $true
        }
        It "Sets TokenType to bearer" {
            $sessionCredential.TokenType | Should -Be 'bearer'
        }
    }
    Context "AccessToken parameter" {
        It "Should set SecretServer to <_>" -TestCases $secretServerHost {
            $sessionAccessToken.SecretServer | Should -Be $_
        }
        It "Sets AccessToken to <_>" -TestCases $sessionAccessToken {
            $sessionAccessToken.AccessToken | Should $_
        }
        It "ApiUrl Property is set" {
            $sessionAccessToken.ApiUrl | Should -Not -BeNullOrEmpty
        }
        It "Does not populate a RefreshToken Property" {
            $sessionAccessToken.RefreshToken | Should -BeNullOrEmpty
        }
        It "SessionExpire() method should return true" {
            $sessionAccessToken.SessionExpire() | Should -Be $true
        }
        It "Does not calculate a TimeOfDeath" {
            $expectedValue = [datetime]::UtcNow.Add([timespan]::FromSeconds($expiresIn))
            $sessionAccessToken.TimeOfDeath | Should -BeLessOrEqual $expectedValue
        }
        It "Calculates StartTime" {
            $currentTime = [datetime]::UtcNow
            $sessionAccessToken.StartTime | Should -BeLessOrEqual $currentTime
        }
        It "Sets TokenType to ExternalToken" {
            $sessionAccessToken.TokenType | Should -Be 'ExternalToken'
        }
    }
}
