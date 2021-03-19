BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id', 'WhenHeartbeatFails', 'WhenViewed', 'WhenChanged', 'Comment', 'TicketNumber', 'TicketSystemId'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
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

            $secretId = Get-Random -Maximum 30
            Mock -Verifiable -CommandName Invoke-TssRestApi -ParameterFilter { $Uri -eq "$($session.ApiUrl)/secrets/$secretId/email"; $Method -eq 'PATCH' } -MockWith {
                return [pscustomobject]@{
                    sendEmailWhenViewed         = @{fieldInputType = ""; sortOrder = ""; value = $false; label = 'Send Email When Viewed'; name = ""; description = ""; readOnly = $false; placeholder = ""; hidden = $false; hideOnView = ""; hasHistory = ""; isRequired = ""; readOnlyReason = ""; helpLink = "" }
                    sendEmailWhenChanged        = @{fieldInputType = ""; sortOrder = ""; value = $true; label = 'Send Email When Changed'; name = ""; description = ""; readOnly = $false; placeholder = ""; hidden = $false; hideOnView = ""; hasHistory = ""; isRequired = ""; readOnlyReason = ""; helpLink = "" }
                    sendEmailWhenHeartbeatFails = @{fieldInputType = ""; sortOrder = ""; value = $false; label = 'Send Email When Heartbeat Fails'; name = ""; description = ""; readOnly = $false; placeholder = ""; hidden = $false; hideOnView = ""; hasHistory = ""; isRequired = ""; readOnlyReason = ""; helpLink = "" }
                    rdpLauncherSettings         = @{fieldInputType = ""; sortOrder = ""; value = ""; label = ""; name = ""; description = ""; readOnly = ""; placeholder = ""; hidden = $false; hideOnView = ""; hasHistory = ""; isRequired = ""; readOnlyReason = ""; helpLink = "" }
                    sshLauncherSettings         = @{fieldInputType = ""; sortOrder = ""; value = ""; label = ""; name = ""; description = ""; readOnly = $true; placeholder = ""; hidden = $true; hideOnView = ""; hasHistory = ""; isRequired = ""; readOnlyReason = ""; helpLink = "" }
                    oneTimePasswordSettings     = @{fieldInputType = ""; sortOrder = ""; value = ""; label = ""; name = ""; description = ""; readOnly = ""; placeholder = ""; hidden = $false; hideOnView = ""; hasHistory = ""; isRequired = ""; readOnlyReason = ""; helpLink = "" }
                    expirationType              = @{fieldInputType = ""; sortOrder = ""; value = 'Template'; label = 'Expiration Type'; name = ""; description = ""; readOnly = $false; placeholder = ""; hidden = ""; hideOnView = ""; hasHistory = ""; isRequired = ""; readOnlyReason = ""; helpLink = "" }
                    expirationDayInterval       = @{fieldInputType = ""; sortOrder = ""; value = ""; label = 'Expiration Day Interval'; name = ""; description = ""; readOnly = $false; placeholder = ""; hidden = ""; hideOnView = ""; hasHistory = ""; isRequired = ""; readOnlyReason = ""; helpLink = "" }
                    expirationDate              = @{fieldInputType = ""; sortOrder = ""; value = ""; label = 'Expiration Date'; name = ""; description = ""; readOnly = $false; placeholder = ""; hidden = ""; hideOnView = ""; hasHistory = ""; isRequired = ""; readOnlyReason = ""; helpLink = "" }
                    expirationTemplateText      = @{fieldInputType = ""; sortOrder = ""; value = 'Expires every 30 day(s)'; label = 'Expiration Template Text'; name = ""; description = ""; readOnly = $false; placeholder = ""; hidden = ""; hideOnView = ""; hasHistory = ""; isRequired = ""; readOnlyReason = ""; helpLink = "" }
                }
            }
            $object = Enable-TssSecretEmail -TssSession $session -Id $secretId -WhenChanged
            Assert-VerifiableMock
        }
        It "Should be empty" {
            $object | Should -BeNullOrEmpty
        }
    }
}