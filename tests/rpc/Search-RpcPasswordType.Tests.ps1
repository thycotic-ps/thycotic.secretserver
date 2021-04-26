BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'SearchText', 'IncludeInactive', 'SortBy'
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
        It "$commandName should set OutputType to TssPasswordTypeSummary" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'TssPasswordTypeSummary'
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

            Mock -Verifiable -CommandName Invoke-RestMethod -ParameterFilter { $Uri -match '/remote-password-changing/password-types' } -MockWith {
                return [pscustomobject]@{
                    records = @(
                        [pscustomobject]@{
                            active             = $true
                            canEdit            = $false
                            hasCommands        = $false
                            heartbeatScriptId  = 0
                            ignoreSSL          = $false
                            isWeb              = $false
                            name               = "Password Type 1"
                            passwordTypeId     = 1
                            requiredEdition    = $null
                            rpcScriptId        = 1
                            runnerType         = 'Standard'
                            scanItemTemplateId = 1
                            useSSL             = $false
                        }
                        [pscustomobject]@{
                            active             = $true
                            canEdit            = $false
                            hasCommands        = $false
                            heartbeatScriptId  = 0
                            ignoreSSL          = $false
                            isWeb              = $false
                            name               = "Password Type 2"
                            passwordTypeId     = 2
                            requiredEdition    = $null
                            rpcScriptId        = 1
                            runnerType         = 'Standard'
                            scanItemTemplateId = 1
                            useSSL             = $false
                        }
                    )
                }
            }
            $object = Search-RpcPasswordType -TssSession $session -SearchText 'Password'
            Assert-VerifiableMock
        }
        It "Should not be empty" {
            $object | Should -Not -BeNullOrEmpty
        }
        It "Should contain 2 records" {
            $object.Count | Should -Be 2
        }
        It "Should have property <_>" -TestCases 'Active', 'Name' {
            $object[0].PSObject.Properties.Name | Should -Contain $_
        }
        It "Should have property Name equal 'Password Type 1'" {
            $object[0].Name | Should -Be 'Password Type 1'
        }
        It "Should have called Invoke-RestMethod 2 times" {
            Assert-MockCalled -CommandName Invoke-RestMethod -Times 2 -Scope Describe
        }
    }
}