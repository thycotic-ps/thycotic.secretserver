BeforeDiscovery {
    $dangerousCommands = @(
            @{ Name = 'New-TssAdvancedConfigurationSetting'; Arguments = "-AdvancedSettingId 12 -Value '30'"; Danger = 'SupportOnlySetting' }
            @{ Name = 'Update-TssAdvancedConfigurationSetting'; Arguments = "-AdvancedSettingId 12 -Value '30'"; Danger = 'SupportOnlySetting' }
            @{ Name = 'Remove-TssAdvancedConfigurationSetting'; Arguments = "-Id 12"; Danger = 'SupportOnlySetting' }
            @{ Name = 'Set-TssDatabaseConfiguration'; Arguments = "-DatabaseName 'SecretServer'"; Danger = 'NodeDatabaseConfiguration' }
            @{ Name = 'Set-TssPlatformConfiguration'; Arguments = "-ProfileName 'pester'"; Danger = 'PlatformAccess' }
            @{ Name = 'Enable-TssUnifiedMode'; Arguments = ""; Danger = 'PlatformAccess' }
            @{ Name = 'Set-TssUnifiedModeStatus'; Arguments = "-Status Started"; Danger = 'PlatformAccess' }
            @{ Name = 'Reset-TssPlatformUserMapping'; Arguments = ""; Danger = 'PlatformAccess' }
            @{ Name = 'Set-TssPlatformUserMapping'; Arguments = "-PlatformUserId 'pester' -UserId 2"; Danger = 'PlatformAccess' }
    )
}
Describe 'Dangerous operations' {
    BeforeAll {
        . ([System.IO.Path]::Combine($PSScriptRoot, '_helperscripts', 'NoHostRunspace.ps1'))
        $shell = New-TssNoHostShell
        $null = Invoke-TssNoHostCase -Shell $shell -Script @"
& (Get-Module Thycotic.SecretServer) {
    function global:Invoke-TssDangerProbe {
        [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
        param([string]`$Danger = 'SupportOnlySetting', [switch]`$Force)
        Confirm-TssDangerousOperation `$PSCmdlet `$Danger 'Probe target' 'Probe action' -Force:`$Force
    }
}
"@
        $warningText = @{
            SupportOnlySetting        = 'These settings are only to be updated by Delinea Support. Modifying them will have a major impact on Secret Server'
            NodeDatabaseConfiguration = 'The database configuration is set per web node. This change applies only to the node that receives the request, so the session must point directly at that node, not at a load-balanced address.'
            PlatformAccess            = 'Changing the Platform configuration, unified mode or Platform user mappings can cause loss of access to the Delinea Platform.'
            EncryptionKeys            = 'This changes how Secret Server encrypts its data. A wrong or interrupted change can leave Secret Server or its secrets unreadable.'
        }
        function Get-PromptFailure {
            param($Case)
            @($Case.Errors | Where-Object { "$_" -like '*prompts the user failed*' })
        }
    }
    AfterAll {
        $shell.Dispose()
    }

    Context 'Confirm-TssDangerousOperation' {
        It 'returns True without any prompt when -Force is passed' {
            $case = Invoke-TssNoHostCase -Shell $shell -Script 'Invoke-TssDangerProbe -Force'
            $case.Errors | Should -BeNullOrEmpty
            $case.Output.Count | Should -Be 1
            $case.Output[0] | Should -BeTrue
        }
        It 'asks OK to proceed when -Force is not passed' {
            $case = Invoke-TssNoHostCase -Shell $shell -Script 'Invoke-TssDangerProbe'
            $failure = Get-PromptFailure $case
            $failure.Count | Should -Be 1
            "$($failure[0])" | Should -BeLike "*$($warningText.SupportOnlySetting)*"
            $case.Output | Should -Not -Contain $true
        }
        It 'still asks OK to proceed with -Confirm:$false when -Force is not passed' {
            $case = Invoke-TssNoHostCase -Shell $shell -Script 'Invoke-TssDangerProbe -Confirm:$false'
            (Get-PromptFailure $case).Count | Should -Be 1
            $case.Output | Should -Not -Contain $true
        }
        It 'asks for confirmation when -Force and -Confirm are both passed' {
            $case = Invoke-TssNoHostCase -Shell $shell -Script 'Invoke-TssDangerProbe -Force -Confirm'
            $failure = Get-PromptFailure $case
            $failure.Count | Should -Be 1
            "$($failure[0])" | Should -BeLike '*Performing the operation "Probe action" on target "Probe target"*'
            $case.Output | Should -Not -Contain $true
        }
        It 'returns False without any prompt for -WhatIf' {
            $case = Invoke-TssNoHostCase -Shell $shell -Script 'Invoke-TssDangerProbe -WhatIf'
            $case.Errors | Should -BeNullOrEmpty
            $case.Output.Count | Should -Be 1
            $case.Output[0] | Should -BeFalse
        }
        It 'returns False without any prompt for -WhatIf even with -Force' {
            $case = Invoke-TssNoHostCase -Shell $shell -Script 'Invoke-TssDangerProbe -Force -WhatIf'
            $case.Errors | Should -BeNullOrEmpty
            $case.Output[0] | Should -BeFalse
        }
        It 'returns False without any prompt when the global $WhatIfPreference is set' {
            $case = Invoke-TssNoHostCase -Shell $shell -Script '$global:WhatIfPreference = $true; try { Invoke-TssDangerProbe } finally { $global:WhatIfPreference = $false }'
            $case.Errors | Should -BeNullOrEmpty
            $case.Output[0] | Should -BeFalse
        }
        It 'honors -WhatIf:$false over $WhatIfPreference' {
            $case = Invoke-TssNoHostCase -Shell $shell -Script '$global:WhatIfPreference = $true; try { Invoke-TssDangerProbe -WhatIf:$false -Force } finally { $global:WhatIfPreference = $false }'
            $case.Errors | Should -BeNullOrEmpty
            $case.Output[0] | Should -BeTrue
        }
        It 'writes the <_> warning' -ForEach @('SupportOnlySetting', 'NodeDatabaseConfiguration', 'PlatformAccess', 'EncryptionKeys') {
            $case = Invoke-TssNoHostCase -Shell $shell -Script "Invoke-TssDangerProbe -Danger $_ -WhatIf"
            $case.Warnings | Should -HaveCount 1
            $case.Warnings[0] | Should -BeExactly $warningText[$_]
        }
    }

    Context '<Name>' -ForEach $dangerousCommands {
        BeforeAll {
            $command = Get-Command $Name -Module Thycotic.SecretServer
            $invocation = "$Name -TssSession (New-TssTestSession) $Arguments"
        }
        It 'exposes -Force as a switch' {
            $command.Parameters['Force'].ParameterType | Should -Be ([System.Management.Automation.SwitchParameter])
        }
        It 'sets ConfirmImpact to High' {
            ($command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }).ConfirmImpact | Should -Be 'High'
        }
        It 'documents -Force and why it is dangerous' {
            $help = Get-Help $Name
            ($help.parameters.parameter | Where-Object Name -EQ 'Force').description.Text | Should -Not -BeNullOrEmpty
            ($help.description.Text -join ' ') | Should -BeLike '*asks OK to proceed?*'
        }
        It 'sends nothing for -WhatIf' {
            $case = Invoke-TssNoHostCase -Shell $shell -Script "$invocation -WhatIf"
            $case.Calls | Should -BeNullOrEmpty
            $case.Errors | Should -BeNullOrEmpty
            $case.Warnings | Should -Contain $warningText[$Danger]
        }
        It 'asks OK to proceed and sends nothing without -Force' {
            $case = Invoke-TssNoHostCase -Shell $shell -Script $invocation
            $case.Calls | Should -BeNullOrEmpty
            (Get-PromptFailure $case).Count | Should -Be 1
        }
        It 'sends one request without any prompt for -Force' {
            $case = Invoke-TssNoHostCase -Shell $shell -Script "$invocation -Force"
            $case.Calls.Count | Should -Be 1
            Get-PromptFailure $case | Should -BeNullOrEmpty
            $case.Warnings | Should -Contain $warningText[$Danger]
        }
    }
}
