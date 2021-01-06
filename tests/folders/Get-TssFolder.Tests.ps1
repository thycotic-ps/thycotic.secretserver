BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
    Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession','Id','GetChildren','IncludeTemplates','Raw'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName, 'Function')).Parameters.Keys
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
        It "$commandName should set OutputType to TssFolderTemplate" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'TssFolderTemplate'
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
        $tssSecretFolder = $getFolders.Where({$_.folderPath -eq '\tss_module_testing'})

        $object = Get-TssFolder $session -Id $tssSecretFolder.Id -GetChildren
        $session.SessionExpire()
        $props = 'Id','FolderName','ChildFolders','SecretTemplates'
    }
    Context "Checking" -Foreach @{object = $object} {
        It "Should not be empty" {
            $object | Should -Not -BeNullOrEmpty
        }
        It "Should find one child folder" {
            $object.ChildFolders | Should -Not -BeNullOrEmpty
        }
        It "Should output <_> property" -TestCases $props {
            $object.PSObject.Properties.Name | Should -Contain $_
        }
    }
}