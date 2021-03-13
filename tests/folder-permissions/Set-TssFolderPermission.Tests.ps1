BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id', 'FolderId', 'FolderAccessRoleName', 'SecretAccessRoleName', 'BreakInheritance'
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

        Mock -Verifiable -CommandName Invoke-TssRestApi -MockWith {
            return [pscustomobject]@{
                GroupId = (Get-Random -Maximum 20)
                FolderAccessRoleId = (Get-Random -Maximum 5)
                SecretAccessRoleId = (Get-Random -Maximum 8)
            }
        }
        $object = Set-TssFolderPermission -TssSession $session -Id 34 -FolderId 5 -FolderAccessRoleName 'Edit'
        Assert-VerifiableMock
    }
    Context "Checking" -Foreach {object = $object}{
        It "Should be empty" {
            $object | Should -BeNullOrEmpty
        }
    }
}