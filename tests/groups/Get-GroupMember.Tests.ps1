BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id', 'IncludeInactive', 'UserDomainId', 'SortBy'
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
        It "$commandName should set OutputType to TssGroupUserSummary" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'TssGroupUserSummary'
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
                        Version = '10.9.000000'
                    }
                }
            }

            Mock -Verifiable -CommandName Invoke-RestMethod -ParameterFilter { $Uri -match '/groups/7/users' } -MockWith {
                return [pscustomobject]@{
                    records = @(
                        [pscustomobject]@{
                            displayName = 'User 1'
                            enabled = $true
                            groupDomainId = -1
                            groupDomainName = $null
                            groupId = 7
                            groupName = "Good Group"
                            userDomainId = -1
                            userDomainName = $null
                            userId = 10
                            userName = "user1"
                        }
                        [pscustomobject]@{
                            displayName = 'User 2'
                            enabled = $true
                            groupDomainId = -1
                            groupDomainName = $null
                            groupId = 7
                            groupName = "Good Group"
                            userDomainId = -1
                            userDomainName = $null
                            userId = 11
                            userName = "user2"
                        }
                    )
                }
            }
            $object = Get-GroupMember -TssSession $session -Id 7
            Assert-VerifiableMock
        }
        It "Should not be empty" {
            $object | Should -Not -BeNullOrEmpty
        }
        It "Should contain 2 records" {
            $object.Count | Should -Be 2
        }
        It "Should have property <_>" -TestCases 'GroupId', 'Enabled' {
            $object[0].PSObject.Properties.Name | Should -Contain $_
        }
        It "Should have property GroupId equal 7" {
            $object[0].GroupId | Should -Be 7
        }
        It "Should have called Invoke-RestMethod 2 times" {
            Assert-MockCalled -CommandName Invoke-RestMethod -Times 2 -Scope Describe
        }
    }
}