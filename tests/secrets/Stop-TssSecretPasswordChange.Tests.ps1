BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession','Id'
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
        $secret = Get-TssSecret @params | Stop-TssSecretPasswordChange -TssSession $session
        $session.SessionExpire()

        $props = 'SecretId','Status','Notes'
    }
    Context "Checking" -Foreach @{secret = $secret} {
        It "Should not be empty" {
            $secret | Should -Not -BeNullOrEmpty
        }
        It "$commandName should get property <_> at minimum" -TestCases $props {
            $secret.PSObject.Properties.Name | Should -Contain $_
        }
    }
}