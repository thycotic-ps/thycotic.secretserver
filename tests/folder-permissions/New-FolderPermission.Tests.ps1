BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'FolderId', 'GroupId', 'UserId', 'FolderAccessRoleName', 'SecretAccessRoleName'
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
        It "$commandName should set OutputType to TssFolderPermission" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'TssFolderPermission'
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

            Mock -Verifiable -CommandName Invoke-TssRestApi -ParameterFilter { $Uri -eq "$($session.ApiUrl)/folder-permissions" } -MockWith {
                return [pscustomobject]@{
                    folderAccessRoleId   = 7
                    folderAccessRoleName = 'Edit'
                    folderId             = 999
                    groupId              = 0
                    groupName            = ""
                    id                   = 888
                    knownAs              = $null
                    secretAccessRoleId   = ""
                    secretAccessRoleName = ""
                    userId               = 497
                    userName             = 'Something'
                }
            }
            $object = New-TssFolderPermission -TssSession $session -FolderId 999 -UserId 497 -FolderAccessRoleName Edit -SecretAccessRoleName None
            Assert-VerifiableMock
        }
        It "Should not be empty" {
            $object | Should -Not -BeNullOrEmpty
        }
        It "Should have property <_>" -TestCases 'FolderAccessRoleName', 'GroupId', 'SecretAccessRoleName' {
            $object[0].PSObject.Properties.Name | Should -Contain $_
        }
        It "Should have property FolderAccessRoleId equal 7" {
            $object.FolderAccessRoleId | Should -Be 7
        }
    }
}