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
        . ([IO.Path]::Combine([string]$PSScriptRoot,'..','..', 'src', 'classes', 'TssSession.class.ps1'))
        Mock -CommandName Invoke-TssRestApi -MockWith {
            return @{
                GroupId = (Get-Random -Maximum 20)
                FolderAccessRoleId = (Get-Random -Maximum 5)
                SecretAccessRoleId = (Get-Random -Maximum 8)
            }
        }
        Mock New-TssSession -MockWith {
            return [TssSession]@{
                ApiVersion   = 'api/v1'
                Take         = 2147483647
                SecretServer = 'http://vault3/'
                ApiUrl       = 'http://vault3/api/v1'
                AccessToken  = 'AgJf5YLFWtzw2UcBrM1s1KB2BGZ5Ufc4qLZeRE3-sYkrTRt5zp_19C-Z8FQbgtID9xz9hHmm0BfL9DzEsDI1gVjG7Kltpq-K3SOa3WbYLIgIb9FGwW2vV6JYvcW4uEBqPBvcY9l4fHKIKJ5pyLp'
                RefreshToken = '9oacYFZZ0YqgBNg0L7VNIF6-Z9ITE51QpljgpuZRVkse4xnv5 rten1Y_3_L2MQX7cflVy7iDbRIuj-ohkVnVfXbYdRQqQmrCTB 3j7VcSKlkLXF2FnUP4LnObcgucrBEUdgS1UN0bySXZ8RJh_ez'
                TokenType    = 'bearer'
                ExpiresIn    = 1199
            }
        }
        $session = New-TssSession -SecretServer 'http://vault3' -AccessToken (Get-Random)
    }
    Context "Checking" {
        It "Should be empty" {
            { Set-TssFolderPermission -Id 34 -FolderId 5 -FolderAccessRoleName 'Edit' } | Should -Not -BeNullOrEmpty
        }
    }
}