BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id'
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
        It "$commandName should set OutputType to TssRoleSummary" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'TssRoleSummary'
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

            $userId = Get-Random -Maximum 42
            Mock -Verifiable -CommandName Invoke-RestMethod -ParameterFilter { $Uri -match "/users/$userId/roles" } -MockWith {
                return [pscustomobject]@{
                    records = @(
                        [pscustomobject]@{
                            name   = "string"
                            roleId = 1
                        }
                        [pscustomobject]@{
                            name   = "string"
                            roleId = 2
                        }
                        [pscustomobject]@{
                            name   = "string"
                            roleId = 3
                        }
                    )
                }
            }
            $object = Get-UserRole -TssSession $session -Id $userId
            Assert-VerifiableMock
        }
        It "Should not be empty" {
            $object | Should -Not -BeNullOrEmpty
        }
        It "Should return 3 objects" {
            $object.Count | Should -Be 3
        }
        It "Should have property <_>" -TestCases 'Name', 'RoleId' {
            $object[0].PSObject.Properties.Name | Should -Contain $_
        }
        It "Should have property RoleId equal 1" {
            $object[0].RoleId | Should -Be 1
        }
        It "Should have called Invoke-RestMethod 2 times" {
            Assert-MockCalled -CommandName Invoke-RestMethod -Times 2 -Scope Describe
        }
    }
}