BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id', 'IncludeInactive'
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
    Context "Command specific details" {
        It "$commandName should set OutputType to TssFolderPermission" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'TssFolderPermission'
        }
    }
}
Describe "$commandName functions" {
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

        Mock -Verifiable -CommandName Invoke-TssRestApi -ParameterFilter { $Uri -eq "$($session.ApiUrl)/folder-permissions/888" } -MockWith {
            return [pscustomobject]@{
                folderAccessRoleId   = 10
                folderAccessRoleName = 'Edit'
                folderId             = 999
                groupId              = 0
                groupName            = ""
                id                   = 888
                knownAs              = $null
                secretAccessRoleId   = 11
                secretAccessRoleName = ""
                userId               = 497
                userName             = 'Something'
            }
        }

        $object = Get-TssFolderPermission -TssSession $session -Id 888
        Assert-VerifiableMock
    }
    Context "Checking" -Foreach @{object = $object} {
        It "Should not be empty" {
            $object | Should -Not -BeNullOrEmpty
        }
        It "Should output <_> property" -TestCases 'FolderAccessRoleId', 'GroupId', 'SecretAccessRoleName' {
            $object.PSObject.Properties.Name | Should -Contain $_
        }
    }
}