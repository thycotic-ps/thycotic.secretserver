BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'DomainId', 'IncludeInactive', 'Field', 'SearchText', 'SortBy'
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
        It "$commandName should set OutputType to TssUserSummary" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'TssUserSummary'
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

            $scriptPath = [IO.Path]::Combine($PSScriptRoot, '..', '_helperscripts', 'randomString.ps1')
            $stringSongName = & $scriptPath
            Mock -Verifiable -CommandName Invoke-RestMethod -ParameterFilter { $Uri -match '/users' } -MockWith {
                return [pscustomobject]@{
                    records     = @(
                        [pscustomobject]@{
                            created              = '1970-01-01T00:00:00.000Z'
                            displayName          = $stringSongName
                            domainId             = 0
                            domainName           = 'string'
                            emailAddress         = 'string'
                            enabled              = $false
                            id                   = 0
                            isApplicationAccount = $false
                            isLockedOut          = $false
                            lastLogin            = '1970-01-01T00:00:00.000Z'
                            loginFailures        = 0
                            userName             = 'string'
                        }
                    )
                }
            }
            $object = Search-User -TssSession $session -SearchText $stringSongName
            Assert-VerifiableMock
        }
        It "Should not be empty" {
            $object | Should -Not -BeNullOrEmpty
        }
        It "Should have property <_>" -TestCases 'Username', 'DomainName', 'DisplayName' {
            $object[0].PSObject.Properties.Name | Should -Contain $_
        }
        It "Should have property DisplayName with a value" {
            $object.DisplayName | Should -Not -BeNullOrEmpty
        }
        It "Should have called Invoke-RestMethod 2 times" {
            Assert-MockCalled -CommandName Invoke-RestMethod -Times 2 -Scope Describe
        }
    }
}