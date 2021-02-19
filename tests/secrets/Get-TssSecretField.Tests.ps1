BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id', 'Slug', 'OutFile',
        # restricted
        'Comment', 'DoublelockPassword', 'ForceCheckin', 'IncludeInactive', 'TicketNumber', 'TicketSystemId'
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
        It "$commandName should set OutputType to System.String" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'System.String'
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

        $invokeParams.Uri = $session.ApiUrl, "folders?take=$($session.take)" -join '/'
        $invokeParams.ExpandProperty = 'records'

        $getFolders = Invoke-TssRestApi @invokeParams
        $tssSecretFolder = $getFolders.Where({$_.folderPath -eq '\tss_module_testing\GetTssSecret'})

        $invokeParams.Uri = $session.ApiUrl, "secrets?take=$($session.Take)&filter.folderId=$($tssSecretFolder.id)" -join '/'
        $getSecrets = Invoke-TssRestApi @invokeParams | Where-Object Name -eq 'Test File Attachment Secret'

        $object = Get-TssSecretField -TssSession $session -Id $getSecrets.id -Slug 'username'
        $objectFile = Get-TssSecretField -TssSession $session -Id $getSecrets.id -Slug 'attached-file'

        if (-not $tssTestUsingWindowsAuth) {
            $session.SessionExpire()
        }
    }
    Context "Checking" -Foreach @{object = $object;objectFile = $objectFile} {
        It "Should not be empty" {
            $object | Should -Not -BeNullOrEmpty
        }
        It "Should return fileusername1 as value" {
            $object | Should -Be 'fileusername1'
        }
        It "Should return attachment content" {
            $objectFile | Should -Not -BeNullOrEmpty
        }
    }
}