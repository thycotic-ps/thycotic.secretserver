BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'UserId'
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
    Context "Command specific details" {
        It "$commandName should set OutputType to TssUserAuditSummary" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'TssUserAuditSummary'
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

            $userId = Get-Random -Maximum 10
            Mock -Verifiable -CommandName Invoke-RestMethod -ParameterFilter { $Uri -match "/users/$userId/audit" } -MockWith {
                return [pscustomobject]@{
                    records = @(
                        [pscustomobject]@{
                            Action              = 'CREATEUSER'
                            DatabaseName        = 'SecretServer'
                            DateRecorded        = '3/19/2021 3:19:16 AM'
                            DisplayName         = 'SS Admin'
                            DisplayNameAffected = 'SS User'
                            IpAddress           = '10.20.1.1'
                            MachineName         = 'sqllab'
                            Notes               = $null
                            UserId              = 2
                            UserIdAffected      = $userId
                        }
                        [pscustomobject]@{
                            Action              = 'EDIT'
                            DatabaseName        = 'SecretServer'
                            DateRecorded        = '3/12/2021 3:19:16 AM'
                            DisplayName         = 'SS Admin'
                            DisplayNameAffected = 'SS User'
                            IpAddress           = '10.20.1.1'
                            MachineName         = 'sqllab'
                            Notes               = 'EmailAddress: ssuser@lab.local to ssuser2@lab.local;'
                            UserId              = 2
                            UserIdAffected      = $userId
                        }
                        [pscustomobject]@{
                            Action              = 'EDIT'
                            DatabaseName        = 'SecretServer'
                            DateRecorded        = '3/04/2021 3:19:16 AM'
                            DisplayName         = 'SS Admin'
                            DisplayNameAffected = 'SS User'
                            IpAddress           = '10.20.1.1'
                            MachineName         = 'sqllab'
                            Notes               = 'IsLockedOut: false to true;'
                            UserId              = 2
                            UserIdAffected      = $userId
                        }
                    )
                }
            }
            $object = Get-UserAudit -TssSession $session -UserId $userId
            Assert-VerifiableMock
        }
        It "Should not be empty" {
            $object | Should -Not -BeNullOrEmpty
        }
        It "Should have property <_>" -TestCases 'UserId','UserIdAffected','Action' {
            $object[0].PSObject.Properties.Name | Should -Contain $_
        }
        It "Should have property UserId equals 2" {
            $object[0].UserId | Should -Be 2
        }
        It "Should have object count of 3" {
            $object.Count | Should -Be 3
        }
        It "Should have called Invoke-RestMethod 2 times" {
            Assert-MockCalled -CommandName Invoke-RestMethod -Times 2 -Scope Describe
        }
    }
}