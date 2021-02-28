BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id',
            <# Restricted params #>
            'Comment', 'ForceCheckIn', 'TicketNumber', 'TicketSystemId',

            <# CheckIn #>
            'CheckIn',

            <# Fields Params #>
            'Field', 'Value', 'Clear',

            <# Email settings #>
            'EmailWhenChanged', 'EmailWhenViewed', 'EmailWhenHeartbeatFails',

            <# General settings #>
            'Active', 'EnableInheritSecretPolicy', 'Folder', 'GenerateSshKeys', 'HeartbeatEnabled', 'SecretPolicy', 'Site', 'Template','IsOutOfSync', 'SecretName',

            <# Other params for PUT /secrets/{id} endpoint #>
            'AutoChangeEnabled', 'AutoChangeNextPassword', 'EnableInheritPermission'

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

Describe "$commandName works" -Skip:$tssTestUsingWindowsAuth {
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
        $getFolder = Invoke-TssRestApi @invokeParams | Where-Object Folderpath -eq '\tss_module_testing\SetTssSecret'

        $getSecrets = Find-TssSecret -TssSession $session -FolderId $getFolder.id -IncludeInactive:$false

        $secretId = $getSecrets.Where({$_.SecretName -eq 'Test Setting Field'}).SecretId
        $setField = Get-TssSecret -TssSession $session -Id $secretId

        $secretId = $getSecrets.Where({$_.SecretName -eq 'Test Setting Email'}).SecretId
        $setEmail = Get-TssSecret -TssSession $session -Id $secretId
        $secretId = $getSecrets.Where({$_.SecretName -eq 'Test Setting Restricted Email'}).SecretId
        $setRestrictedEmail = Get-TssSecret -TssSession $session -Id $secretId -Comment "tssModule Test execution"

        $secretId = $getSecrets.Where({$_.SecretName -match 'Test Setting General Settings'}).SecretId
        $setGeneral = Get-TssSecret -TssSession $session -Id $secretId
        $secretId = $getSecrets.Where({$_.SecretName -match 'Test Setting Restricted General Settings'}).SecretId
        $setRestrictedGeneral = Get-TssSecret -TssSession $session -Id $secretId -Comment "tssModule Test execution"

        $secretId = $getSecrets.Where({$_.SecretName -eq 'Test Setting AutoChangeEnabled AutoChangeNextPassword EnableInheritPermissions'}).SecretId
        $setOther = Get-TssSecret -TssSession $session -Id $secretId
    }
    Context "Set a secret field" -Foreach @{setField = $setField;session = $session} {
        It "Should set the value on the Notes field" {
            $valueField = "your friendly local PowerShell Module"
            Set-TssSecret -TssSession $session -Id $setField.Id -Field Notes -Value $valueField | Should -BeNullOrEmpty
        }
        It "Should Clear the Notes field" {
            Set-TssSecret -TssSession $session -Id $setField.Id -Field Notes -Clear | Should -BeNullOrEmpty
        }
    }
    Context "Sets email settings of a secret" -Foreach @{setEmail = $setEmail;setRestrictedEmail = $setRestrictedEmail;session = $session} {
        AfterAll {
            $invokeParams.Uri = $session.ApiUrl, 'secrets', $setRestrictedEmail.Id, 'check-in' -join '/'
            $invokeParams.Method = 'POST'
            $invokeParams.Remove('ExpandProperty')
            Invoke-TssRestApi @invokeParams
        }
        It "Should set EmailWhenChanged" {
            Set-TssSecret -TssSession $session -Id $setEmail.Id -EmailWhenChanged:$false | Should -BeNullOrEmpty
        }
        It "Should set EmailWhenViewed" {
            Set-TssSecret -TssSession $session -Id $setEmail.Id -EmailWhenViewed:$false | Should -BeNullOrEmpty
        }
        It "Should set EmailWhenHeartbeatFails" {
            Set-TssSecret -TssSession $session -Id $setEmail.Id -EmailWhenHeartbeatFails:$false | Should -BeNullOrEmpty
        }
        It "Should set EmailWhenViewed on Restricted secret (require checkout/comment)" {
            Set-TssSecret -TssSession $session -Id $setRestrictedEmail.Id -EmailWhenViewed:$false | Should -BeNullOrEmpty
        }
    }
    Context "Sets general settings of a secret" -Foreach @{setGeneral = $setGeneral;setRestrictedGeneral = $setRestrictedGeneral; session = $session} {
        AfterAll {
            $invokeParams.Uri = $session.ApiUrl, 'secrets', $setRestrictedGeneral.Id, 'check-in' -join '/'
            $invokeParams.Method = 'POST'
            $invokeParams.Remove('ExpandProperty')
            Invoke-TssRestApi @invokeParams
        }
        <# not going to test all of them, just enough #>
        It "Should set Name" {
            $newName = "Test Setting General Settings $(Get-Random)"
            Set-TssSecret -TssSession $session -Id $setGeneral.Id -SecretName $newName | Should -BeNullOrEmpty
        }
        It "Should set HeartbeatEnabled" {
            Set-TssSecret -TssSession $session -Id $setGeneral.Id -HeartbeatEnabled:$false | Should -BeNullOrEmpty
        }
        It "Should set Active" {
            Set-TssSecret -TssSession $session -Id $setGeneral.Id -Active | Should -BeNullOrEmpty
        }
        It "Should set Name on Restricted Secret (require checkout/comment)" {
            $newRestrictedName = "Test Setting Restricted General Settings $(Get-Random)"
            Set-TssSecret -TssSession $session -Id $setRestrictedGeneral.Id -SecretName $newRestrictedName
        }
    }
    Context "Sets other settings of a secret" -Foreach @{setOther = $setOther;session = $session} {
        It "Should set AutoChangeEnabled" {
            Set-TssSecret -TssSession $session -Id $setOther.Id -AutoChangeEnabled | Should -BeNullOrEmpty
        }
        It "Should set AutoChangeNextPassword" {
            $secureString = ConvertTo-SecureString -String ("tssModuleWasHere$((New-Guid).Guid)") -AsPlainText -Force
            Set-TssSecret -TssSession $session -Id $setOther.Id -AutoChangeNextPassword $secureString | Should -BeNullOrEmpty
        }
        It "Should set EnableInheritPermissions" {
            Set-TssSecret -TssSession $session -Id $setOther.Id -EnableInheritPermission | Should -BeNullOrEmpty
        }
    }
}