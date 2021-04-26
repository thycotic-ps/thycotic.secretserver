BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Template'
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
        It "$commandName should set OutputType to TssSecretTemplate" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'TssSecretTemplate'
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

            Mock -Verifiable -CommandName Invoke-RestMethod -ParameterFilter { $Uri -match '/secret-templates' } -MockWith {
                return [pscustomobject]@{
                    Name           = "Test Template"
                    Id             = 6999
                    PasswordTypeId = 1
                    Fields         = @(
                        [pscustomobject]@{
                            Description                  = "The Server or Location of the Active Directory Domain."
                            DisplayName                  = "Domain"
                            EditablePermission           = 2
                            FieldSlugName                = "domain"
                            GeneratePasswordCharacterSet = $null
                            GeneratePasswordLength       = 0
                            HideOnView                   = $false
                            HistoryLength                = 2147483647
                            IsExpirationField            = $false
                            IsFile                       = $false
                            IsIndexable                  = $true
                            IsNotes                      = $false
                            IsPassword                   = $false
                            IsRequired                   = $false
                            IsUrl                        = $false
                            MustEncrypt                  = $true
                            Name                         = "Domain"
                            PasswordRequirementId        = -1
                            PasswordTypeFieldId          = 1
                            SecretTemplateFieldId        = 87
                        }
                    )
                }
            }

            $templateObject = [pscustomobject]@{
                Name   = 'Test Template'
                Fields = @(
                    [pscustomobject]@{
                        Description                  = "The Server or Location of the Active Directory Domain."
                        DisplayName                  = "Domain"
                        EditablePermission           = 2
                        EditRequires                 = "Edit"
                        FieldSlugName                = "domain"
                        GeneratePasswordCharacterSet = ""
                        GeneratePasswordLength       = 0
                        HideOnView                   = $false
                        HistoryLength                = 2147483647
                        IsExpirationField            = $false
                        IsFile                       = $false
                        IsIndexable                  = $true
                        IsNotes                      = $false
                        IsPassword                   = $false
                        IsRequired                   = $false
                        IsUrl                        = $false
                        MustEncrypt                  = $true
                        Name                         = "Domain"
                        PasswordRequirementId        = -1
                        PasswordTypeFieldId          = 1
                        SecretTemplateFieldId        = 87
                    }
                )
            }
            $object = New-SecretTemplate -TssSession $session -Template $templateObject
            Assert-VerifiableMock
        }
        It "Should not be empty" {
            $object | Should -Not -BeNullOrEmpty
        }
        It "Should have property <_>" -TestCases Name, Id, Fields {
            $object[0].PSObject.Properties.Name | Should -Contain $_
        }
        It "Should have property Id equal 6999" {
            $object.Id | Should -Be 6999
        }
        It "Should have called Invoke-RestMethod 2 times" {
            Assert-MockCalled -CommandName Invoke-RestMethod -Times 2 -Scope Describe
        }
    }
}