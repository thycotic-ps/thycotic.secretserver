BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'ParentFolderId', 'SearchText', 'PermissionRequired', 'SortBy'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
    }
    Context "Verify parmaeters" -Foreach @{currentParams = $currentParams} {
        It "$commandName should contain <_> parameter" -TestCases $knownParameters {
            $_ -in $currentParams | Should -Be $true
        }
        It "$commandName should not contain parameter: <_>" -TestCases $unknownParameters {
            $_ | Should -BeNullOrEmpty
        }
    }
    Context "Command specific details" {
        It "$commandName should set OutputType to TssFolderLookup" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'TssFolderLookup'
        }
    }
}
Describe "$commandName works" {
    BeforeDiscovery {
        $session = New-TssSession -SecretServer $ss -Credential $ssCred
        $invokeParams = @{
            Uri = "$ss/api/v1/folders?take=$($session.take)"
            ExpandProperty = 'records'
            PersonalAccessToken = $session.AccessToken
        }
        $getFolders = Invoke-TssRestApi @invokeParams
        $tssSecretFolder = $getFolders.Where({$_.folderName -eq 'tss_module_testing'})

        $searchText = 'SearchTssSecret'
        # Prep work
        $findObject = Find-TssFolder -TssSession $session -ParentFolderId $tssSecretFolder.Id
        $findTextObject = Find-TssFolder -TssSession $session -SearchText $searchText

        $session.SessionExpire()
        $props = 'FolderId', 'Id', 'FolderId'
    }
    Context "Checking" -Foreach @{findObject = $findObject; findTextObject = $findTextObject} {
        It "Should not be empty" {
            $findObject | Should -Not -BeNullOrEmpty
            $findTextObject | Should -Not -BeNullOrEmpty
        }
        It "Should output <_> property" -TestCases $props {
            $findObject[0].PSObject.Properties.Name | Should -Contain $_
        }
        It "Should have <_> in FolderName" -TestCases $searchText {
            $findObject.FolderName | Should -Contain $_
        }
        It "Should have only pulled <_> Folder" -TestCases $searchText {
            $findTextObject.FolderName | Should -Be $_
        }
    }
}