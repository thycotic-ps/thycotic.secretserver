BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'SecretServer', 'Credential', 'AccessToken', 'UseWindowsAuth'
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
    Context "Validates SecretServer argument" {
        It "Should catch invalid URL arguments" {
            { New-TssSession -SecretServer 'https://alpha/api/v1' -AccessToken "$(Get-Random)" } | Should -Throw
        }
        It "Should not contain double forward slashes in PathAndQuery of ApiUrl" {
            ([uri](New-TssSession -SecretServer 'https://alpah/SecretServer/' -AccessToken "$(Get-Random)").ApiUrl).PathAndQuery | Should -Not -Match "(?:\/\/)"
        }
    }
    Context "Credential parameter" -Skip:$tssTestUsingWindowsAuth {
        BeforeAll {
            $apiV = 'api/v1'
            $sessionCredential = New-TssSession -SecretServer $ss -Credential $ssCred
        }
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
            $expectedValue = "{0:yyyy}-{0:MM}-{0:dd} {0:hh}:{0:mm}" -f [datetime]::Now.Add([timespan]::FromSeconds($expiresIn))
            "{0:yyyy}-{0:MM}-{0:dd} {0:hh}:{0:mm}" -f $sessionCredential.TimeOfDeath | Should -BeGreaterOrEqual $expectedValue
        }
        It "Calculates StartTime" {
            $currentTime = "{0:yyyy}-{0:MM}-{0:dd} {0:hh}:{0:mm}" -f [datetime]::Now
            "{0:yyyy}-{0:MM}-{0:dd} {0:hh}:{0:mm}" -f $sessionCredential.StartTime | Should -BeGreaterOrEqual $currentTime
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
        BeforeAll {
            $secretServerHost = 'https://tenant.secretservercloud.com'
            $generatedAccessToken = (New-Guid).Guid
            $sessionAccessToken = New-TssSession -SecretServer $secretServerHost -AccessToken $generatedAccessToken
        }
        It "Should set SecretServer to <_>" -TestCases $secretServerHost {
            $sessionAccessToken.SecretServer | Should -Be $_
        }
        It "Sets AccessToken to <_>" -TestCases $generatedAccessToken {
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
        It "SessionRefresh() method should return false" {
            $sessionAccessToken.SessionRefresh() 3>$null | Should -Be $false
        }
        It "Does not calculate a TimeOfDeath" {
            "{0:yyyy}-{0:MM}-{0:dd}" -f $sessionAccessToken.TimeOfDeath | Should -Be ([datetime]'0001-01-01')
        }
        It "Calculates StartTime" {
            $currentTime = "{0:yyyy}-{0:MM}-{0:dd} {0:hh}:{0:mm}" -f [datetime]::Now
            "{0:yyyy}-{0:MM}-{0:dd} {0:hh}:{0:mm}" -f $sessionAccessToken.StartTime | Should -BeLessOrEqual $currentTime
        }
        It "Sets TokenType to ExternalToken" {
            $sessionAccessToken.TokenType | Should -Be 'ExternalToken'
        }
    }
    Context "UseWindowsAuth" {
        BeforeAll {
            $secretServerHost = 'https://tenant.secretservercloud.com'
            $sessionWinAuth = New-TssSession -SecretServer $secretServerHost -UseWindowsAuth
        }
        It "Should set SecretServer to <_>" -TestCases $secretServerHost {
            $sessionWinAuth.SecretServer | Should -Be $_
        }
        It "Does not set AccessToken" {
            $sessionWinAuth.AccessToken | Should -BeNullOrEmpty
        }
        It "ApiUrl Property is set" {
            $sessionWinAuth.ApiUrl | Should -Not -BeNullOrEmpty
        }
        It "Does not populate a RefreshToken Property" {
            $sessionWinAuth.RefreshToken | Should -BeNullOrEmpty
        }
        It "SessionExpire() method should return false" {
            $sessionWinAuth.SessionExpire() 3>$null | Should -Be $false
        }
        It "SessionRefresh() method should return false" {
            $sessionWinAuth.SessionRefresh() 3>$null | Should -Be $false
        }
        It "Does not calculate a TimeOfDeath" {
            "{0:yyyy}-{0:MM}-{0:dd}" -f $sessionWinAuth.TimeOfDeath | Should -Be ([datetime]'0001-01-01')
        }
        It "Calculates StartTime" {
            $currentTime = "{0:yyyy}-{0:MM}-{0:dd} {0:hh}:{0:mm}" -f [datetime]::Now
            "{0:yyyy}-{0:MM}-{0:dd} {0:hh}:{0:mm}" -f $sessionWinAuth.StartTime | Should -BeLessOrEqual $currentTime
        }
        It "Sets TokenType to WindowsAuth" {
            $sessionWinAuth.TokenType | Should -Be 'WindowsAuth'
        }
    }
}
