BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id', 'BreakInheritance'
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
        It "$commandName should set OutputType to TssDelete" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'TssDelete'
        }
    }
}
Describe "$commandName functions" {
    BeforeAll {
        . ([IO.Path]::Combine([string]$PSScriptRoot,'..','..', 'src', 'classes', 'TssSession.class.ps1'))
        Mock -ModuleName Thycotic.SecretServer -CommandName Invoke-TssRestApi -MockWith {
            return @{
                Id            = $folderPermissionId
                ObjectType    = $objectType
                responseCodes = @{}
            }
        }
        Mock -ModuleName Thycotic.SecretServer -Command New-TssSession -MockWith {
            return [TssSession]@{
                ApiVersion   = 'api/v1'
                Take         = 2147483647
                SecretServer = 'http://alpha/'
                ApiUrl       = 'http://alpha/api/v1'
                AccessToken  = 'AgJf5YLFWtzw2UcBrM1s1KB2BGZ5Ufc4qLZeRE3-sYkrTRt5zp_'
                RefreshToken = '9oacYFZZ0YqgBNg0L7VNIF6-Z9ITE51QpljgpuZRVkse4xnv416'
                TokenType    = 'bearer'
                ExpiresIn    = 1199
            }
        }

        $session = New-TssSession -SecretServer 'http://alpha' -AccessToken (Get-Random)
        $object = Remove-TssFolderPermission -TssSession $session -Id 34
    }
    Context "Checking" -Foreach {object = $object}{
        It "Should not be empty" {
            $object | Should -Not -BeNullOrEmpty
        }
        It "Should have property <_>" -TestCases 'Id','ObjectType' {
            $object[0].PSObject.Properties.Name | Should -Contain $_
        }
    }
}