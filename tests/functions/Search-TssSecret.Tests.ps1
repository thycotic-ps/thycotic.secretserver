BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName veirfy parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession','Raw','Permission','Scope',
        # Folder param set
        'FolderId','IncludeSubFolders',
        # field param set
        'Field','FieldText','ExactMatch','FieldSlug','ExtendedField','ExtendedTypeId',
        # secret param set
        'SecretTemplateId','SiteId','HeartbeatStatus','IncludeInactive','ExcludeActive','RpcEnabled','SharedWithMe','PasswordTypeIds','ExcludeDoubleLock','DoubleLockId'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName, 'Function')).Parameters.Keys
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
        It "$commandName should set OutputType to TssSecretSummary" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'TssSecretSummary'
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
        $tssSecretFolder = $getFolders.Where({$_.folderPath -match '\tss_module_testing\SearchTssSecret'})

        $objectRpc = Search-TssSecret $session -RpcEnabled -SecretTemplateId 6001 -FolderId $tssSecretFolder.Id
        $object = Search-TssSecret $session -FolderId $tssSecretFolder.Id -IncludeSubFolders
        $props = 'SecretId','FolderId','SecretTemplateId','Name'

        $session.SessionExpire()
    }
    Context "Checking" -Foreach @{object = $object; objectRpc = $objectRpc} {
        It "Should not be empty" {
            $object | Should -Not -BeNullOrEmpty
        }
        It "Should find one secret with RPC enabled" {
            $objectRpc.SecretTemplateId | Should -Be 6001
        }
        It "Should return more than one secret" {
            $object.Count | Should -BeGreaterOrEqual 2
        }
        It "Should output <_> property" -TestCases $props {
            $object.PSObject.Properties.Name | Should -Contain $_
        }
    }
}
Describe "$commandName works" {
    BeforeDiscovery {
        $session = New-TssSession -SecretServer $ss -Credential $ssCred
        $object = Search-TssSecret $session -RpcEnabled -SecretTemplateId 6003
        $session.SessionExpire()

        $props = 'SecretId','FolderId','SecretTemplateId','SecretName'
    }
    Context "Checking" -Foreach @{object = $object} {
        It "Should not be empty" {
            $object | Should -Not -BeNullOrEmpty
        }
        It "Should find one secret with RPC enabled" {
            $object.SecretTemplateId | Should -Be 6003
        }
        It "Should output <_> property" -TestCases $props {
            $object.PSObject.Properties.Name | Should -Contain $_
        }
    }
}