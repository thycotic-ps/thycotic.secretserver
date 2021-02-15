BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession','FolderStub', 'FolderName', 'ParentFolderId', 'SecretPolicyId', 'InheritPermissions', 'InheritSecretPolicy'
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
        It "$commandName should set OutputType to TssSecret" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'TssSecret'
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
        $tssSecretFolder = $getFolders.Where( { $_.FolderPath -eq '\tss_module_testing\NewFolder' })

        $stub = Get-TssFolderStub -TssSession $session

        $testCase = [pscustomobject]@{
            FolderName         = "tssNewFolder$(Get-Random)"
            ParentFolder       = $tssSecretFolder.Id
            InheritPermissions = $true
        }

        $newParams = @{
            TssSession         = $session
            FolderStub         = $stub
            FolderName         = $testCase.FolderName
            ParentFolderId     = $testCase.ParentFolder
            InheritPermissions = $testCase.InheritPermissions
        }
        $newFolder = New-TssFolder @newParams
        $createdFolder = Get-TssFolder -TssSession $session -Id $newFolder.Id
        $props = 'FolderId', 'FolderName', 'ParentFolderId', 'InheritPermissions'

        if (-not $tssTestUsingWindowsAuth) {
            $session.SessionExpire()
        }
    }
    Context "Checking" -Foreach @{newFolder = $newFolder } {
        It "Should not be empty" {
            $newFolder | Should -Not -BeNullOrEmpty
        }
        It "Should output <_> property" -TestCases $props {
            $newFolder.PSObject.Properties.Name | Should -Contain $_
        }
    }
    Context "Validate created folder" -ForEach @{createdFolder = $createdFolder } {
        BeforeDiscovery {
            $invokeParams = @{}
            if ($tssTestUsingWindowsAuth) {
                $session = New-TssSession -SecretServer $ss -UseWindowsAuth
                $invokeParams.UseDefaultCredentials = $true
            } else {
                $session = New-TssSession -SecretServer $ss -Credential $ssCred
                $invokeParams.PersonalAccessToken = $session.AccessToken
            }

            $invokeParams.Uri = $($session.ApiUrl), "folders/$($createdFolder.FolderId)" -join '/'
            $invokeParams.Method = 'DELETE'
            $deletedFolder = Invoke-TssRestApi @invokeParams
            if ($deletedFolder.id -ne $createdFolder.FolderId) {
                Write-Host "Unable to properly delete created test folder"
            }
            if (-not $tssTestUsingWindowsAuth) {
                $session.SessionExpire()
            }
        }
        It "Should not be empty" {
            $createdFolder | Should -Not -BeNullOrEmpty
        }
        It "Should have set FolderName to <_.FolderName>" -TestCases $testCase {
            $createdFolder.FolderName | Should -Be $_.FolderName
        }
        It "Should not have zero for FolderId" -TestCases $testCase {
            $createdFolder.FolderId | Should -Not -Be 0
        }
        It "Should have ParentFolderId set to <_.ParentFolder>" -TestCases $testCase {
            $createdFolder.ParentFolderId | Should -Be $_.ParentFolder
        }
        It "Should have InheritPermissions set to <_.InheritPermissions>" -TestCases $testCase {
            $createdFolder.InheritPermissions | Should -Be $_.InheritPermissions
        }
    }
}