BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession','Id'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
    }
    Context "Verify parameters" -Foreach @{currentParams = $currentParams} {
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

            $secretIdTrue = 42
            Mock -Verifiable -CommandName Invoke-RestMethod -ParameterFilter { $Uri -match "/secrets/$secretIdTrue/stop-password-change" } -MockWith {
                return [pscustomobject]@{
                        success = $true
                }
            }
            $secretIdFalse = 43
            Mock -Verifiable -CommandName Invoke-RestMethod -ParameterFilter { $Uri -match "/secrets/$secretIdFalse/stop-password-change" } -MockWith {
                return [pscustomobject]@{
                        success = $false
                }
            }
            $objectTrue = Stop-SecretChangePassword -TssSession $session -Id $secretIdTrue
            $objectFalse = Stop-SecretChangePassword -TssSession $session -Id $secretIdFalse
            Assert-VerifiableMock
        }
        It "Should not be empty when true" {
            $objectTrue | Should -Not -BeNullOrEmpty
        }
        It "Should have property <_> when True" -TestCases 'SecretId', 'Status' {
            $objectTrue[0].PSObject.Properties.Name | Should -Contain $_
        }
        It "Should have property SecretId with a value when True" {
            $objectTrue.SecretId | Should -Not -BeNullOrEmpty
        }
        It "Should be empty when False" {
            $objectFalse | Should -BeNullOrEmpty
        }
        It "Should have called Invoke-RestMethod 3 times" {
            Assert-MockCalled -CommandName Invoke-RestMethod -Times 3 -Scope Describe
        }
    }
}