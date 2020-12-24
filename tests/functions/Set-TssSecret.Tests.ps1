﻿BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . "$PSScriptRoot\constants.ps1"
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id', 'Comment',
            'Field', 'Value', 'Clear',
            'EmailWhenChanged', 'EmailWhenViewed', 'EmailWhenHeartbeatFails'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName, 'Function')).Parameters.Keys
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
}

Describe "$commandName works" {
    BeforeDiscovery {
        $session = New-TssSession -SecretServer $ssVault1 -Credential $vault1Cred

        $invokeParams = @{
            Uri = "$ssVault1/api/v1/folders?take=$($session.take)"
            Method = 'GET'
            ExpandProperty = 'records'
            PersonalAccessToken = $session.AccessToken
        }
        $getFolders = Invoke-TssRestApi @invokeParams
        $tssFolder = $getFolders.Where({$_.folderPath -match 'tss_module_testing\\SetTssSecret'})
    }
    Context "Set a secret field and property" {
        BeforeDiscovery {
            $session = New-TssSession -SecretServer $ssVault1 -Credential $vault1Cred

            $invokeParams = @{
                Uri = "$ssVault1/api/v1/secrets/lookup?take=$($session.take)&folderid=$($TssFolder.id)"
                Method = 'GET'
                PersonalAccessToken = $session.AccessToken
                ExpandProperty = 'records'
            }
            $getSecrets = Invoke-TssRestApi @invokeParams

            $secretId = $getSecrets.Where({$_.value -match 'Test Setting Field and Property'}).id
            $invokeParams = @{
                Uri = "$ssVault1/api/v1/secrets/$secretId"
                Method = 'GET'
                PersonalAccessToken = $session.AccessToken
            }
            $setSecret = Invoke-TssRestApi @invokeParams
        }
        It "Should set the value on the Notes field" -TestCases $setSecret {
            $session = New-TssSession -SecretServer $ssVault1 -Credential $vault1Cred
            $valueField = "your friendly local PowerShell Module"
            Set-TssSecret -TssSession $session -Id $_.id -Field Notes -Value $valueField | Should -BeNullOrEmpty
        }
        It "Should Clear the Notes field" -TestCases $setSecret {
            $session = New-TssSession -SecretServer $ssVault1 -Credential $vault1Cred
            Set-TssSecret -TssSession $session -Id $_.Id -Field Notes -Clear | Should -BeNullOrEmpty
        }
        It "Should set EmailWhenChanged" -TestCases $setSecret {
            $session = New-TssSession -SecretServer $ssVault1 -Credential $vault1Cred
            Set-TssSecret -TssSession $session -Id $_.Id -EmailWhenChanged:$false | Should -BeNullOrEmpty
        }
        It "Should set EmailWhenViewed" -TestCases $setSecret {
            $session = New-TssSession -SecretServer $ssVault1 -Credential $vault1Cred
            Set-TssSecret -TssSession $session -Id $_.Id -EmailWhenViewed:$false | Should -BeNullOrEmpty
        }
        It "Should set EmailWhenHeartbeatFails" -TestCases $setSecret {
            $session = New-TssSession -SecretServer $ssVault1 -Credential $vault1Cred
            Set-TssSecret -TssSession $session -Id $_.Id -EmailWhenHeartbeatFails:$false | Should -BeNullOrEmpty
        }
    }
}