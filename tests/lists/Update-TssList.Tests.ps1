BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'List'
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
        It "$commandName should set OutputType to Thycotic.PowerShell.Lists.List" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.Lists.List'
        }
    }
}
Describe "$commandName functions" {
    Context "Checking" {
        BeforeAll {
            $session = [pscustomobject]@{
                ApiVersion         = 'api/v1'
                Take               = 2147483647
                SecretServer       = 'http://alpha/'
                SecretServerVersion= '10.9.000064'
                ApiUrl             = 'http://alpha/api/v1'
                AccessToken        = 'AgJf5YLChrisPine312UcBrM1s1KB2BGZ5Ufc4qLZ'
                RefreshToken       = '9oacYeah0YqgBNg0L7VinDiesel6-Z9ITE51Humus'
                TokenType          = 'bearer'
                ExpiresIn          = 1199
            }

            Mock -Verifiable -CommandName Invoke-RestMethod -ParameterFilter { $Uri -match '/Endpoint' } -MockWith {
                return [pscustomobject]@{
                    # Object expected by REST API call
                }
            }
            $object = Endpoint -TssSession $session Parameters
            Assert-VerifiableMock
        }
        It "Should not be empty" {
            $object | Should -Not -BeNullOrEmpty
        }
        It "Should have property <_>" -TestCases Properties {
            $object[0].PSObject.Properties.Name | Should -Contain $_
        }
        It "Should have property Property equal value" {
            $object.Property | Should -Be value
        }
        It "Should have called Invoke-RestMethod 2 times" {
            Assert-MockCalled -CommandName Invoke-RestMethod -Times 2 -Scope Describe
        }
    }
}