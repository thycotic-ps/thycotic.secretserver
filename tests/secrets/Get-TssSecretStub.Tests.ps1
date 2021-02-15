﻿BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession','SecretTemplateId', 'FolderId'
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
        It "$commandName should set OutputType to TssSecret" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'TssSecret'
        }
    }
}
Describe "$commandName works" {
    BeforeDiscovery {
        $session = New-TssSession -SecretServer $ss -Credential $ssCred
        $invokeParams = @{
            Uri = "$ss/api/v1/secret-templates?take=$($session.take)&filter.searchText=tssFileTemplate"
            ExpandProperty = 'records'
            PersonalAccessToken = $session.AccessToken
        }
        $getTemplates = Invoke-TssRestApi @invokeParams

        $invokeParams = @{
            Uri                 = "$ss/api/v1/folders?take=$($session.take)"
            ExpandProperty      = 'records'
            PersonalAccessToken = $session.AccessToken
        }
        $getFolders = Invoke-TssRestApi @invokeParams
        $tssSecretFolder = $getFolders.Where( { $_.folderPath -eq '\tss_module_testing' })

        $tssFileTemplateId = $getTemplates.id
        $tssFolderId = $tssSecretFolder.Id

        # Prep work
        $stub = Get-TssSecretStub -TssSession $session -SecretTemplateId $tssFileTemplateId
        $stubWithFolder = Get-TssSecretStub -TssSession $session -SecretTemplateId $tssFileTemplateId -FolderId $tssFolderId

        $session.SessionExpire()
        $props = 'Name', 'Active', 'SecretTemplateId', 'FolderId'
    }
    Context "Checking" -Foreach @{stub = $stub;stubWithFolder = $stubWithFolder} {
        It "Should not be empty" {
            $stub | Should -Not -BeNullOrEmpty
        }
        It "Should output <_> property" -TestCases $props {
            $stub.PSObject.Properties.Name | Should -Contain $_
        }
        It "Should have SecretTemplateID of <_>" -TestCases $tssFileTemplateId {
            $stub.SecretTemplateId | Should -Be $_
        }
        It "Should have FolderId of <_>" -TestCases $tssFolderId {
            $stubWithFolder.FolderId | Should -Be $_
        }
    }
}