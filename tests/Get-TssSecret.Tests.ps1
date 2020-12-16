BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id', 'Comment', 'Raw'
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
    Context "Command speicifc details" {
        It "$commandName should set OutputType to TssSecret" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'TssSecret'
        }
    }
}

Describe "$commandName works - basic level" {
    BeforeDiscovery {
        . "$PSScriptRoot\constants.ps1"
        $session = New-TssSession -SecretServer $ssVault1 -Credential $vault1Cred

        $invokeParams = @{
            Uri = "$ssVault1/api/v1/folders?take=$($session.take)"
            ExpandProperty = 'records'
            PersonalAccessToken = $session.AccessToken
        }
        $getFolders = Invoke-TssRestApi @invokeParams
        $tssSecretFolder = $getFolders.Where({$_.folderPath -match 'tss_module_testing\\GetTssSecret'})
        $getSecrets = Invoke-TssRestApi -Uri "$ssVault1/api/v1/secrets??take=$($session.take)&folderid=$($TssSecretFolder.id)" -Method Get -PersonalAccessToken $session.AccessToken -ExpandProperty records

        $params = @{
            TssSession = $session
            Id = $getSecrets[0].id
        }
        $secret = Get-TssSecret @params
    }
    Context "Basic checks for output and pipe support" -Foreach @{secret = $secret} {
        It "Should not be empty" {
            $secret | Should -Not -BeNullOrEmpty
        }
        It "Should output type of TssSecret" {
            $secret.PSTypeNames | Should -Contain 'TssSecret'
        }

        It "$commandName should get property <_> at minimum" -TestCases 'SecretId','Name', 'SecretTemplateName' {
            $secret.PSObject.Properties.Name | Should -Contain $_
        }
    }
}