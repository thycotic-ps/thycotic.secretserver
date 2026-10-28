BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'BackupDatabasePath', 'BackupFailureNotification', 'BackupPath', 'BackupStartDateTime', 'ConfigurationSqlBackupTimeoutMinutes', 'CopyOnlyDatabaseBackup', 'EnableDatabaseBackup', 'EnableScheduledBackup', 'EnableTmsBackup', 'EnableWebApplicationBackup', 'NumberOfBackupsToKeep', 'RepeatDays', 'RepeatHours', 'RepeatMinutes', 'TmsInstallationPath'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession'); Optional = @('BackupDatabasePath', 'BackupFailureNotification', 'BackupPath', 'BackupStartDateTime', 'ConfigurationSqlBackupTimeoutMinutes', 'CopyOnlyDatabaseBackup', 'EnableDatabaseBackup', 'EnableScheduledBackup', 'EnableTmsBackup', 'EnableWebApplicationBackup', 'NumberOfBackupsToKeep', 'RepeatDays', 'RepeatHours', 'RepeatMinutes', 'TmsInstallationPath'); Absent = @() }
        )
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
        It "$commandName should set OutputType to Thycotic.PowerShell.Configuration.Backup" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.Configuration.Backup'
        }
        It "$commandName should support ShouldProcess" -TestCases $commandDetails {
            $_.Parameters.ContainsKey('WhatIf') | Should -Be $true
        }
        It "$commandName should set ConfirmImpact to Medium" -TestCases $commandDetails {
            ($_.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }).ConfirmImpact | Should -Be 'Medium'
        }
        It "$commandName should take TssSession as Thycotic.PowerShell.Authentication.Session" -TestCases $commandDetails {
            $_.Parameters['TssSession'].ParameterType.FullName | Should -Be 'Thycotic.PowerShell.Authentication.Session'
        }
        It "$commandName should take BackupDatabasePath as System.String" -TestCases $commandDetails {
            $_.Parameters['BackupDatabasePath'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take BackupFailureNotification as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['BackupFailureNotification'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take BackupPath as System.String" -TestCases $commandDetails {
            $_.Parameters['BackupPath'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take BackupStartDateTime as System.DateTime" -TestCases $commandDetails {
            $_.Parameters['BackupStartDateTime'].ParameterType.FullName | Should -Be 'System.DateTime'
        }
        It "$commandName should take ConfigurationSqlBackupTimeoutMinutes as System.Int32" -TestCases $commandDetails {
            $_.Parameters['ConfigurationSqlBackupTimeoutMinutes'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take CopyOnlyDatabaseBackup as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['CopyOnlyDatabaseBackup'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take EnableDatabaseBackup as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['EnableDatabaseBackup'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take EnableScheduledBackup as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['EnableScheduledBackup'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take EnableTmsBackup as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['EnableTmsBackup'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take EnableWebApplicationBackup as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['EnableWebApplicationBackup'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take NumberOfBackupsToKeep as System.Int32" -TestCases $commandDetails {
            $_.Parameters['NumberOfBackupsToKeep'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take RepeatDays as System.Int32" -TestCases $commandDetails {
            $_.Parameters['RepeatDays'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take RepeatHours as System.Int32" -TestCases $commandDetails {
            $_.Parameters['RepeatHours'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take RepeatMinutes as System.Int32" -TestCases $commandDetails {
            $_.Parameters['RepeatMinutes'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take TmsInstallationPath as System.String" -TestCases $commandDetails {
            $_.Parameters['TmsInstallationPath'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take TssSession from the pipeline (ValueFromPipeline)" -TestCases $commandDetails {
            @($_.Parameters['TssSession'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] -and $_.ValueFromPipeline }).Count | Should -BeGreaterThan 0
        }
        It "$commandName should bind TssSession at position 0" -TestCases $commandDetails {
            @($_.Parameters['TssSession'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] }).Position | Should -Contain 0
        }
    }
    Context "Parameter set <SetName>" -Foreach $setCases {
        BeforeAll {
            $set = (Get-Command $CommandName).ParameterSets.Where({ $_.Name -eq $SetName })[0]
        }
        It "should exist" {
            $set | Should -Not -BeNullOrEmpty
        }
        It "should require exactly <Mandatory>" {
            $actual = $set.Parameters.Where({ $_.IsMandatory }).Name | Sort-Object
            ($actual -join ',') | Should -BeExactly (($Mandatory | Sort-Object) -join ',')
        }
        It "should have exactly <Optional> as optional" {
            $common = [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
            $actual = $set.Parameters.Where({ -not $_.IsMandatory -and $_.Name -notin $common }).Name | Sort-Object
            ($actual -join ',') | Should -BeExactly (($Optional | Sort-Object) -join ',')
        }
        It "should not offer <Absent>" {
            foreach ($name in $Absent) {
                $set.Parameters.Name | Should -Not -Contain $name
            }
        }
    }
}
