BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id', 'Comment',
            <# Fields #>
            'Field', 'Value', 'Clear',
            <# Email settings #>
            'EmailWhenChanged', 'EmailWhenViewed', 'EmailWhenHeartbeatFails',
            <# General settings #>
            'Active', 'EnableInheritSecretPolicy', 'Folder', 'GenerateSshKeys', 'HeartbeatEnabled', 'SecretPolicy', 'Site', 'Template','IsOutOfSync', 'SecretName',
            <# Other params for PUT /secrets/{id} endpoint #>
            'AutoChangeEnabled', 'AutoChangeNextPassword', 'EnableInheritPermissions'
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

        $secretId = $getSecrets.Where({$_.value -match 'Test Setting Field'}).id
        $invokeParams = @{
            Uri = "$ss/api/v1/secrets/$secretId"
            Method = 'GET'
            PersonalAccessToken = $session.AccessToken
        }
        $setField = Invoke-TssRestApi @invokeParams

        $secretId = $getSecrets.Where({$_.value -match 'Test Setting Email'}).id
        $invokeParams = @{
            Uri = "$ss/api/v1/secrets/$secretId"
            Method = 'GET'
            PersonalAccessToken = $session.AccessToken
        }
        $setEmail = Invoke-TssRestApi @invokeParams

        $secretId = $getSecrets.Where({$_.value -match 'Test Setting General Settings'}).id
        $invokeParams = @{
            Uri = "$ss/api/v1/secrets/$secretId"
            Method = 'GET'
            PersonalAccessToken = $session.AccessToken
        }
        $setGeneral = Invoke-TssRestApi @invokeParams

        $secretId = $getSecrets.Where({$_.value -match 'Test Setting AutoChangeEnabled AutoChangeNextPassword EnableInheritPermissions'}).id
        $invokeParams = @{
            Uri = "$ss/api/v1/secrets/$secretId"
            Method = 'GET'
            PersonalAccessToken = $session.AccessToken
        }
        $setOther = Invoke-TssRestApi @invokeParams
    }
    Context "Set a secret field" -Foreach @{secret = $setField;session = $session} {
        It "Should set the value on the Notes field" {
            $valueField = "your friendly local PowerShell Module"
            Set-TssSecret -TssSession $session -Id $secret.id -Field Notes -Value $valueField | Should -BeNullOrEmpty
        }
        It "Should Clear the Notes field" {
            Set-TssSecret -TssSession $session -Id $secret.Id -Field Notes -Clear | Should -BeNullOrEmpty
        }
        It "Should set EmailWhenChanged" {
            Set-TssSecret -TssSession $session -Id $secret.Id -EmailWhenChanged:$false | Should -BeNullOrEmpty
        }
        It "Should set EmailWhenViewed" {
            Set-TssSecret -TssSession $session -Id $secret.Id -EmailWhenViewed:$false | Should -BeNullOrEmpty
        }
        It "Should set EmailWhenHeartbeatFails" {
            Set-TssSecret -TssSession $session -Id $secret.Id -EmailWhenHeartbeatFails:$false | Should -BeNullOrEmpty
        }
    }
    Context "Sets email settings of a secret" -Foreach @{secret = $setEmail;session = $session} {
        It "Should set EmailWhenChanged" {
            Set-TssSecret -TssSession $session -Id $secret.Id -EmailWhenChanged:$false | Should -BeNullOrEmpty
        }
        It "Should set EmailWhenViewed" {
            Set-TssSecret -TssSession $session -Id $secret.Id -EmailWhenViewed:$false | Should -BeNullOrEmpty
        }
        It "Should set EmailWhenHeartbeatFails" {
            Set-TssSecret -TssSession $session -Id $secret.Id -EmailWhenHeartbeatFails:$false | Should -BeNullOrEmpty
        }
    }
    Context "Sets general settings of a secret" -Foreach @{secret = $setGeneral;session = $session} {
        <# not going to test all of them, just enough #>
        It "Should set Name" {
            $newName = "Test Setting General Settings $(Get-Random)"
            Set-TssSecret -TssSession $session -Id $secret.Id -SecretName $newName | Should -BeNullOrEmpty
        }
        It "Should set HeartbeatEnabled" {
            Set-TssSecret -TssSession $session -Id $secret.Id -HeartbeatEnabled:$false | Should -BeNullOrEmpty
        }
        It "Should set Active" {
            Set-TssSecret -TssSession $session -Id $secret.Id -Active | Should -BeNullOrEmpty
        }
    }
    Context "Sets other settings of a secret" -Foreach @{secret = $setOther;session = $session} {
        It "Should set AutoChangeEnabled" {
            Set-TssSecret -TssSession $session -Id $secret.Id -AutoChangeEnabled | Should -BeNullOrEmpty
        }
        It "Should set AutoChangeNextPassword" {
            $secureString = ConvertTo-SecureString -String ("tssmodulewashere$((New-Guid).Guid)") -AsPlainText -Force
            Set-TssSecret -TssSession $session -Id $secret.Id -AutoChangeNextPassword $secureString | Should -BeNullOrEmpty
        }
        It "Should set EnableInheritPermissions" {
            Set-TssSecret -TssSession $session -Id $secret.Id -EnableInheritPermissions | Should -BeNullOrEmpty
        }
    }
}