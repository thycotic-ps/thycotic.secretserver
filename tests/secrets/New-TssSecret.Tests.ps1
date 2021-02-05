BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession','SecretStub'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
    }
    Context "Verify parmaeters" -ForEach @{currentParams = $currentParams } {
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
            Uri                 = "$ss/api/v1/folders?take=$($session.take)"
            ExpandProperty      = 'records'
            PersonalAccessToken = $session.AccessToken
        }
        $getFolders = Invoke-TssRestApi @invokeParams
        $tssSecretFolder = $getFolders.Where( { $_.folderPath -eq '\tss_module_testing\NewSecret' })

        $invokeParams = @{
            Uri = "$ss/api/v1/secret-templates?take=$($session.take)&filter.searchText=tssFileTemplate"
            ExpandProperty = 'records'
            PersonalAccessToken = $session.AccessToken
        }
        $getTemplates = Invoke-TssRestApi @invokeParams

        # Prep work
        $stub = Get-TssSecretStub -TssSession $session -SecretTemplateId $getTemplates.Id -FolderId $tssSecretFolder.Id

        $testCase = [pscustomobject]@{
            SecretName = "tssNewFileSecret$(Get-Random)"
            FolderId = $tssSecretFolder.Id
            Username = "tssUsername$(Get-Random)"
            Password = "$((New-Guid).Guid)"
        }

        $stub.Name = $testCase.SecretName
        $stub.FolderId = $testCase.FolderId
        $stub.Items.SetFieldValue('username',$testCase.Username)
        $stub.Items.SetFieldValue('password',$testCase.Password)

        $newSecret = New-TssSecret -TssSession $session -SecretStub $stub
        $createdSecret = Get-TssSecret -TssSession $session -Id $newSecret.Id

        $session.SessionExpire()
        $props = 'Name', 'ProxyEnabled', 'Items'
    }
    Context "Checking" -ForEach @{newSecret = $newSecret} {
        It "Should not be empty" {
            $newSecret | Should -Not -BeNullOrEmpty
        }
        It "Should output <_> property" -TestCases $props {
            $newSecret.PSObject.Properties.Name | Should -Contain $_
        }
    }
    Context "Validate created secret" -Foreach @{createdSecret = $createdSecret} {
        It "Should not be empty" {
            $createdSecret | Should -Not -BeNullOrEmpty
        }
        It "Should have set secret's Name to <_.SecretName>" -TestCases $testCase {
            $createdSecret.Name | Should -Be $_.SecretName
        }
        It "Should have set FolderId to <_.FolderId>" -TestCases $testCase {
            $createdSecret.FolderId | Should -Be $_.FolderId
        }
        It "Should have set Username to <_.Username>" -TestCases $testCase {
            $createdSecret.GetFieldValue('Username') | Should -Be $_.Username
        }
        It "Should have set Password to <_.Password>" -TestCases $testCase {
            $createdSecret.GetFieldValue('Password') | Should -Be $_.Password
        }
    }
}