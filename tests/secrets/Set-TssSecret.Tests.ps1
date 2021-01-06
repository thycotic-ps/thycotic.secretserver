BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id', 'Comment',
            'Field', 'Value', 'Clear',
            'EmailWhenChanged', 'EmailWhenViewed', 'EmailWhenHeartbeatFails'
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
        # This command is written to not output an object. Nothing if successful, else it writes out the error
    }
}

Describe "$commandName works" {
    BeforeDiscovery {
        $session = New-TssSession -SecretServer $ss -Credential $ssCred

        $invokeParams = @{
            Uri = "$ss/api/v1/folders?take=$($session.take)"
            Method = 'GET'
            ExpandProperty = 'records'
            PersonalAccessToken = $session.AccessToken
        }
        $getFolders = Invoke-TssRestApi @invokeParams | Where-Object Folderpath -eq '\tss_module_testing\SetTssSecret'

        $invokeParams = @{
            Uri = "$ss/api/v1/secrets/lookup?take=$($session.take)&folderid=$($TssFolder.id)"
            Method = 'GET'
            PersonalAccessToken = $session.AccessToken
            ExpandProperty = 'records'
        }
        $getSecrets = Invoke-TssRestApi @invokeParams

        $secretId = $getSecrets.Where({$_.value -match 'Test Setting Field and Property'}).id
        $invokeParams = @{
            Uri = "$ss/api/v1/secrets/$secretId"
            Method = 'GET'
            PersonalAccessToken = $session.AccessToken
        }
        $setSecret = Invoke-TssRestApi @invokeParams

    }
    Context "Set a secret field and property" -Foreach @{secret = $setSecret;session = $session} {
        It "Should set the value on the Notes field" -TestCases $setSecret {
            $valueField = "your friendly local PowerShell Module"
            Set-TssSecret -TssSession $session -Id $secret.id -Field Notes -Value $valueField | Should -BeNullOrEmpty
        }
        It "Should Clear the Notes field" -TestCases $setSecret {
            Set-TssSecret -TssSession $session -Id $secret.Id -Field Notes -Clear | Should -BeNullOrEmpty
        }
        It "Should set EmailWhenChanged" -TestCases $setSecret {
            Set-TssSecret -TssSession $session -Id $secret.Id -EmailWhenChanged:$false | Should -BeNullOrEmpty
        }
        It "Should set EmailWhenViewed" -TestCases $setSecret {
            Set-TssSecret -TssSession $session -Id $secret.Id -EmailWhenViewed:$false | Should -BeNullOrEmpty
        }
        It "Should set EmailWhenHeartbeatFails" -TestCases $setSecret {
            Set-TssSecret -TssSession $session -Id $secret.Id -EmailWhenHeartbeatFails:$false | Should -BeNullOrEmpty
        }
    }
}