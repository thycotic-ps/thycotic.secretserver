BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
    }
    Context "Verify parameters" -ForEach @{currentParams = $currentParams } {
        It "$commandName should contain <_> parameter" -TestCases $knownParameters {
            $_ -in $currentParams | Should -Be $true
        }
        It "$commandName should not contain parameter= $<_>" -TestCases $unknownParameters {
            $_ | Should -BeNullOrEmpty
        }
    }
    Context "Command specific details" {
        It "$commandName should set OutputType to TssUser" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'TssUser'
        }
    }
}
Describe "$commandName functions" {
    Context "Checking" {
        BeforeAll {
            $session = [pscustomobject]@{
                ApiVersion   = 'api/v1'
                Take         = 2147483647
                SecretServer = 'http://alpha/'
                ApiUrl       = 'http://alpha/api/v1'
                AccessToken  = 'AgJf5YLChrisPine312UcBrM1s1KB2BGZ5Ufc4qLZ'
                RefreshToken = '9oacYeah0YqgBNg0L7VinDiesel6-Z9ITE51Humus'
                TokenType    = 'bearer'
                ExpiresIn    = 1199
            }
            Mock -Verifiable -CommandName Invoke-RestMethod -ParameterFilter { $Uri -match '/version' } -MockWith {
                return [pscustomobject]@{
                    model = [pscustomobject]@{
                        Version = '10.9.000000'
                    }
                }
            }

            Mock -Verifiable -CommandName Invoke-RestMethod -ParameterFilter { $Uri -match '/users/stub' } -MockWith {
                return [pscustomobject]@{
                    id                       = 0
                    userName                 = ""
                    displayName              = ""
                    lastLogin                = '1/1/0001 12:00:00 AM'
                    created                  = '1/1/0001 12:00:00 AM'
                    enabled                  = $false
                    loginFailures            = 0
                    emailAddress             = ""
                    userLcid                 = 0
                    domainId                 = -1
                    lastSessionActivity      = '1/1/0001 12:00:00 AM'
                    isLockedOut              = $false
                    radiusUserName           = ""
                    twoFactor                = $false
                    radiusTwoFactor          = $false
                    isEmailVerified          = $false
                    mustVerifyEmail          = $false
                    verifyEmailSentDate      = '1/1/0001 12:00:00 AM'
                    passwordLastChanged      = '1/1/0001 12:00:00 AM'
                    dateOptionId             = -1
                    timeOptionId             = -1
                    isEmailCopiedFromAD      = $false
                    adGuid                   = ""
                    adAccountExpires         = '1/1/0001 12:00:00 AM'
                    resetSessionStarted      = '1/1/0001 12:00:00 AM'
                    isApplicationAccount     = $false
                    oathTwoFactor            = $false
                    oathVerified             = $false
                    duoTwoFactor             = $false
                    fido2TwoFactor           = $false
                    unixAuthenticationMethod = 'Password'
                    lockOutReason            = ""
                    lockOutReasonDescription = ""
                }
            }
            $object = Get-UserStub -TssSession $session
            Assert-VerifiableMock
        }
        It "Should not be empty" {
            $object | Should -Not -BeNullOrEmpty
        }
        It "Should have property <_>" -TestCases 'Username', 'DisplayName' {
            $object[0].PSObject.Properties.Name | Should -Contain $_
        }
        It "Should have called Invoke-RestMethod 2 times" {
            Assert-MockCalled -CommandName Invoke-RestMethod -Times 2 -Scope Describe
        }
    }
}