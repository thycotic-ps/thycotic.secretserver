BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'SearchText', 'IncludeSecretCount', 'IncludeInactive', 'SortBy'
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
        It "$commandName should set OutputType to TssSecretTemplateSummary" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'TssSecretTemplateSummary'
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

            Mock -Verifiable -CommandName Invoke-TssRestApi -ParameterFilter { $Uri -eq "$($session.ApiUrl)/secret-templates?sortBy[0].direction=asc&sortBy[0]=name&take=$($session.Take)?filter.searchText=key";$Method -eq 'GET' } -MockWith {
                return [pscustomobject]@{
                    records = [pscustomobject]@(
                        [pscustomobject]@{id = 6034; name = 'Amazon IAM Key'; secretCount = 0; active = $true }
                        [pscustomobject]@{id = 6038; name = 'Google IAM Service Account Key'; secretCount = 0; active = $true }
                        [pscustomobject]@{id = 14; name = 'Product License Key'; secretCount = 0; active = $true }
                        [pscustomobject]@{id = 6026; name = 'SSH Key'; secretCount = 0; active = $true }
                    )
                }
            }
            $object = Search-TssSecretTemplate -TssSession $session -SearchText 'key'
            Assert-VerifiableMock
        }
        It "Should not be empty" {
            $object | Should -Not -BeNullOrEmpty
        }
        It "Should have property <_>" -TestCases 'Name','Id','Active' {
            $object[0].PSObject.Properties.Name | Should -Contain $_
        }
        It "Should have property Property Name matches the value 'key'" {
            $object[0].Name | Should -BeLike '*key*'
        }
    }
}