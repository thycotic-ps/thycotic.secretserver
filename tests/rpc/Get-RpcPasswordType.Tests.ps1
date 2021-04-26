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
        It "$commandName should set OutputType to TssPasswordType" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'TssPasswordType'
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

            Mock -Verifiable -CommandName Invoke-RestMethod -ParameterFilter { $Uri -match '/remote-password-changing/password-types/52' } -MockWith {
                return [pscustomobject]@{
                    active = $true
                    canEdit = $false
                    customPort = $null
                    exitCommand = $null
                    fields = @(
                        [pscustomobject]@{
                            name = 'Password'
                            passwordTypeFieldId = 0
                            scanItemFieldId = 0
                        }
                    )
                    hasCommands = $false
                    hasLDAPSettings = $false
                    heartbeatScriptArgs = 'string'
                    heartbeatScriptId = 0
                    ignoreSSL = $false
                    isWeb = $false
                    ldapConnectionSettingsId = 0
                    lineEnding = 'NewLine'
                    mainframeConnectionString = $null
                    name = 'Password Type 52'
                    odbcConnectionString = $null
                    passwordTypeId = 52
                    rpcScriptArgs = $null
                    rpcScriptId = 0
                    runnerType = $null
                    scanItemTemplateId = 0
                    typeName = 'Thycotic.ihawu.Business.Federator.PowerShellFederator'
                    useSSL = $false
                    useUsernameAndPassword = $true
                    validForTakeover = $false
                    windowsCustomPorts = $null
                }
            }
            $object = Get-RpcPasswordType -TssSession $session -Id 52
            Assert-VerifiableMock
        }
        It "Should not be empty" {
            $object | Should -Not -BeNullOrEmpty
        }
        It "Should have property <_>" -TestCases PasswordTypeId, Name {
            $object[0].PSObject.Properties.Name | Should -Contain $_
        }
        It "Should have property PasswordTypeId equal 52" {
            $object.PasswordTypeId | Should -Be 52
        }
        It "Should contain 1 Fields record" {
            $object.Fields.Count | Should -Be 1
        }
        It "Should have called Invoke-RestMethod 2 times" {
            Assert-MockCalled -CommandName Invoke-RestMethod -Times 2 -Scope Describe
        }
    }
}