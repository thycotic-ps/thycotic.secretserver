BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id', 'Raw',
        # restricted
        'Comment', 'DoublelockPassword', 'ForceCheckin', 'IncludeInactive', 'TicketNumber', 'TicketSystemId'
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
        It "$commandName should set OutputType to TssSecret" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'TssSecret'
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
        $tssSecretFolder = $getFolders.Where({$_.folderPath -match 'tss_module_testing\\GetTssSecret'})
        $getSecrets = Invoke-TssRestApi -Uri "$ss/api/v1/secrets?take=$($session.take)&folderid=$($tssSecretFolder.id)" -Method Get -PersonalAccessToken $session.AccessToken -ExpandProperty records

        $params = @{
            TssSession = $session
            Id = $getSecrets[0].id
        }
        $secret = Get-TssSecret @params
        $session.SessionExpire()
    }
    Context "Checking" -Foreach @{secret = $secret} {
        It "Should not be empty" {
            $secret | Should -Not -BeNullOrEmpty
        }
        It "$commandName should have parent output type of TssSecret" {
            $secret.PSTypeNames | Should -Contain 'TssSecret'
        }
        It "$commandName Items should have output type TssSecretItem" {
            ($secret.Items).PSTypeNames | Should -Contain 'TssSecretItem[]'
        }
        It "$commandName TssSecret should include GetCredential method" {
            $secret.GetCredential | Should -Not -BeNullOrEmpty
        }
        It "$commandName should get property <_> at minimum" -TestCases 'SecretId','Name', 'SecretTemplateName' {
            $secret.PSObject.Properties.Name | Should -Contain $_
        }
        It "$commandName should return PSCredential with method: GetCredential" {
            $secret.GetCredential() | Should -BeOfType System.Management.Automation.PSCredential
        }
        It "$commandName should return Username field value with method: GetValue" {
            $secret[0].GetFieldValue('username') | Should -Not -BeNullOrEmpty
        }
    }
}