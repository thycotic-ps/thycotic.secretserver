BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession'
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
        It "$commandName should set OutputType to TssFolder" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'TssFolder'
        }
    }
}
Describe "$commandName works" {
    BeforeDiscovery {
        $session = New-TssSession -SecretServer $ss -Credential $ssCred
        $folderStub = Get-TssFolderStub -TssSession $session
        $session.SessionExpire()
        $props = 'FolderId', 'ParentFolderId', 'FolderName'
    }
    Context "Checking" -Foreach @{folderStub = $folderStub} {
        It "Should not be empty" {
            $folderStub | Should -Not -BeNullOrEmpty
        }
        It "Should output <_> property" -TestCases $props {
            $folderStub.PSObject.Properties.Name | Should -Contain $_
        }
        It "Should have ParentFolderId of -1 (negative one)" {
            $folderStub.ParentFolderId | Should -Be -1
        }
    }
}