BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'FolderId'
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
Describe "$commandName works" {
    BeforeDiscovery {
        $invokeParams = @{}
        if ($tssTestUsingWindowsAuth) {
            $session = New-TssSession -SecretServer $ss -UseWindowsAuth
            $invokeParams.UseDefaultCredentials = $true
        } else {
            $session = New-TssSession -SecretServer $ss -Credential $ssCred
            $invokeParams.PersonalAccessToken = $session.AccessToken
        }
        $invokeParams.Uri = $($session.ApiUrl), "folders?take=$($session.take)" -join '/'
        $invokeParams.ExpandProperty = 'records'

        $getFolders = Invoke-TssRestApi @invokeParams
        $tssSecretFolder = $getFolders.Where({$_.folderPath -eq '\tss_module_testing'})

        $folderPermStub = Get-TssFolderPermissionsStub -TssSession $session -FolderId $tssSecretFolder.Id
        $props = 'FolderAccessRoleId', 'GroupId', 'SecretAccessRole'

        if (-not $tssTestUsingWindowsAuth) {
            $session.SessionExpire()
        }
    }
    Context "Checking" -Foreach @{folderPermStub = $folderPermStub} {
        It "Should not be empty" {
            $folderPermStub | Should -Not -BeNullOrEmpty
        }
        It "Should output <_> property" -TestCases $props {
            $folderPermStub.PSObject.Properties.Name | Should -Contain $_
        }
    }
}