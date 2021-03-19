BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id', 'ChangePasswordOnCheckIn', 'Interval', 'Comment', 'TicketNumber', 'TicketSystemId'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
    }
    Context "Verify parameters" -ForEach @{currentParams = $currentParams } {
        It "$commandName should contain <_> parameter" -TestCases $knownParameters {
            $_ -in $currentParams | Should -Be $true
        }
        It "$commandName should not contain parameter= <_>" -TestCases $unknownParameters {
            $_ | Should -BeNullOrEmpty
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
                AccessToken  = 'AgJf5YLFWtzw2UcBrM1s1KB2BGZ5Ufc4qLZ'
                RefreshToken = '9oacYFZZ0YqgBNg0L7VNIF6-Z9ITE51Qplj'
                TokenType    = 'bearer'
                ExpiresIn    = 1199
            }
            Mock -Verifiable -CommandName Get-TssVersion -MockWith {
                return @{
                    Version = '10.9.000033'
                }
            }

            $secretId = Get-Random -Maximum 60
            Mock -Verifiable -CommandName Invoke-TssRestApi -ParameterFilter { $Uri -eq "$($session.ApiUrl)/secrets/$secretId/security-checkout"; $Method -eq 'PATCH' } -MockWith {
                return [pscustomobject]@{
                    checkOutEnabled = @{fieldInputType = 'String'; sortOrder = ""; value = $true; label = 'Require Check Out'; name = ""; description = 'When enabled a user will need to checkout a Secret before they can access it. Checkout will prevent other users from accessing the Secret while it is checked out.' ; readOnly = ""; placeholder = ""; hidden = $false; hideOnView = ""; hasHistory = ""; isRequired = ""; readOnlyReason = ""; helpLink = ""}
                    checkOutIntervalMinutes = @{fieldInputType = 'string'; sortOrder = ""; value = ""; label = 'Check Out Interval'; name = ""; description = 'The number of minutes for which the Secret can remain checked out.'; readOnly = ""; placeholder = ""; hidden = $false; hideOnView = ""; hasHistory = ""; isRequired = ""; readOnlyReason = ""; helpLink = ""}
                    checkOutIntervalDisplay = @{readOnly = $true; fieldInputType = 'String'; sortOrder = ""; value = '30 minutes'; label='Checkout Interval Display'; name = "";description='After this interval expires the Secret will automatically check back in and become available to other users.'; placeholder = "";hidden=$false; hideOnView = "";hasHistory = "";isRequired = "";readOnlyReason = "";helpLink= ""}
                    checkOutDefaultIntervalDisplay = @{readOnly = $true; fieldInputType = 'string'; sortOrder = ""; value = '30 minutes'; label='Default Checkout Interval Display'; name = "";description='After this interval expires the Secret will automatically check back in and become available to other users.'; placeholder = "";hidden=$false; hideOnView = "";hasHistory = "";isRequired = "";readOnlyReason = "";helpLink= ""}
                    checkOutChangePasswordEnabled = @{fieldInputType = 'string'; sortOrder = ""; value = $false; label = 'Change Password on Check In'; name = ""; description = 'When a Secret is checked back in the password will be changed.'; readOnly = $true; placeholder = ""; hidden = $true; hideOnView = ""; hasHistory = ""; isRequired = ""; readOnlyReason = ""; helpLink = ""}
                }
            }
            $object = Enable-TssSecretCheckout -TssSession $session -Id $secretId
            Assert-VerifiableMock
        }
    It "Should be empty" {
            $object | Should -BeNullOrEmpty
        }
    }
}