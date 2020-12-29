BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession','Raw','Permission','Scope',
        # Folder param set
        'FolderId','IncludeSubFolders',
        # field param set
        'Field','FieldText','ExactMatch','FieldSlug','ExtendedField','ExtendedTypeId',
        # secret param set
        'Id','SecretTemplateId','SiteId','HeartbeatStatus','IncludeInactive','ExcludeActive','RpcEnabled','SharedWithMe','PasswordTypeIds','ExcludeDoubleLock','DoubleLockId'
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
        It "$commandName should set OutputType to TssSecretLookup" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'TssSecretLookup'
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

        $object = Find-TssSecret $session -IncludeSubFolders -SecretTemplateId 6001 -FolderId $tssSecretFolder.Id
        $props = 'SecretId','FolderId','SecretTemplateId','SecretName'

        $getSecret = (Invoke-TssRestApi -Uri "$ss/api/v1/secrets??take=$($session.take)&folderid=$($tssSecretFolder.id)" -Method Get -PersonalAccessToken $session.AccessToken -ExpandProperty records)[0]
        $object2 = Find-TssSecret $session -Id $getSecret.Id
        $props2 = 'SecretId','Id','SecretName'
        $session.SessionExpire()
    }
    Context "Checking" -Foreach @{object = $object; object2 = $object2} {
        It "Should not be empty" {
            $object | Should -Not -BeNullOrEmpty
        }
        It "Should output <_> property" -TestCases $props {
            $object.PSObject.Properties.Name | Should -Contain $_
        }
        It "Should output <_> properties when Id param used" -TestCases $props2 {
            $object2.PSObject.Properties.Name | Should -Contain $_
        }
    }
}