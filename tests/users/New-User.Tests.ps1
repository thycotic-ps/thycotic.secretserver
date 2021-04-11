BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Username', 'DisplayName', 'Password', 'Active', 'IsApplicationAccount', 'EmailAddress', 'DomainId', 'AdGuid', 'TwoFactorType' , 'RadiusUsername'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
    }
    Context "Verify parameters" -Foreach @{currentParams = $currentParams } {
        It "$commandName should contain <_> parameter" -TestCases $knownParameters {
            $_ -in $currentParams | Should -Be $true
        }
        It "$commandName should not contain parameter: <_>" -TestCases $unknownParameters {
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
                return @{
                   model = [pscustomobject]@{
                       Version = '10.9.000033'
                   }
                }
            }

            $userId = 42
            Mock -Verifiable -CommandName Invoke-RestMethod -ParameterFilter { $Uri -match '/users' } -MockWith {
                return [pscustomobject]@{
                    adAccountExpires = "1970-01-01T00:00:00.000Z"
                        adGuid = $null
                        created = "1970-01-01T00:00:00.000Z"
                        dateOptionId = 0
                        displayName = "New User"
                        domainId = 0
                        duoTwoFactor = $false
                        emailAddress = "user@new.local"
                        enabled = $false
                        fido2TwoFactor = $false
                        id = $userId
                        isApplicationAccount = $false
                        isEmailCopiedFromAD = $false
                        isEmailVerified = $false
                        isLockedOut = $false
                        lastLogin = "1970-01-01T00:00:00.000Z"
                        lastSessionActivity = "1970-01-01T00:00:00.000Z"
                        lockOutReason = "string"
                        lockOutReasonDescription = "string"
                        loginFailures = 0
                        mustVerifyEmail = $false
                        oathTwoFactor = $false
                        oathVerified = $false
                        passwordLastChanged = "1970-01-01T00:00:00.000Z"
                        radiusTwoFactor = $false
                        radiusUserName = "string"
                        resetSessionStarted = "1970-01-01T00:00:00.000Z"
                        timeOptionId = 0
                        twoFactor = $false
                        unixAuthenticationMethod = 'Password'
                        userLcid = 0
                        userName = "user"
                        verifyEmailSentDate = "1970-01-01T00:00:00.000Z"
                }
            }
            $object = New-User -TssSession $session -Username 'user' -DisplayName 'New User' -Password (ConvertTo-SecureString 'pass' -AsPlainText -Force) -Email 'user@new.local'
            Assert-VerifiableMock
        }
        It "Should not be empty" {
            $object | Should -Not -BeNullOrEmpty
        }
        It "Should have property <_>" -TestCases 'Id', 'DisplayName', 'EmailAddress' {
            $object[0].PSObject.Properties.Name | Should -Contain $_
        }
        It "Should have property DisplayName equal 'New User'" {
            $object.DisplayName | Should -Be 'New User'
        }
        It "Should have called Invoke-RestMethod 2 times" {
            Assert-MockCalled -CommandName Invoke-RestMethod -Times 2 -Scope Describe
        }
    }
}