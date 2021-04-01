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
    Context "Verify parameters" -Foreach @{currentParams = $currentParams } {
        It "$commandName should contain <_> parameter" -TestCases $knownParameters {
            $_ -in $currentParams | Should -Be $true
        }
        It "$commandName should not contain parameter: <_>" -TestCases $unknownParameters {
            $_ | Should -BeNullOrEmpty
        }
    }
    Context "Command specific details" {
        It "$commandName should set OutputType to TssUserRoleSummary" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'TssUserRoleSummary'
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

            $userId = Get-Random -Maximum 543
            Mock -Verifiable -CommandName Invoke-RestMethod -ParameterFilter { $Uri -match "/users/$userId/roles-assigned" } -MockWith {
                return [pscustomobject]@{
                    records     = @(
                        [pscustomobject]@{
                            groups             = @(
                                [pscustomobject]@{
                                    groupId = 1
                                    groupName = "string"
                                }
                                [pscustomobject]@{
                                    groupId = 2
                                    groupName = "string"
                                }
                            )
                            isDirectAssignment = $false
                            roleId = (Get-Random -Maximum 50)
                            roleName = "string"
                        }
                    )
                }
            }
            $object = Get-UserRoleAssigned -TssSession $session -UserId $userId
            Assert-VerifiableMock
        }
        It "Should not be empty" {
            $object | Should -Not -BeNullOrEmpty
        }
        It "Should have property <_>" -TestCases 'Groups', 'RoleId', 'RoleName' {
            $object[0].PSObject.Properties.Name | Should -Contain $_
        }
        It "Should have property Groups with 2 objects" {
            $object.Groups.Count | Should -Be 2
        }
        It "Should have called Invoke-RestMethod 2 times" {
            Assert-MockCalled -CommandName Invoke-RestMethod -Times 2 -Scope Describe
        }
    }
}