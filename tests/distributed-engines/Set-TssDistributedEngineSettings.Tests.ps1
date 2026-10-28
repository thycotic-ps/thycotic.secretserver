BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'EngineSettingsId', 'EngineId', 'AdSyncEnabled', 'AdvancedAuditingEnabled', 'ExternalVaultsEnabled', 'FipsEnabled', 'LocalAccountDiscoveryEnabled', 'LogLevel', 'PasswordChangingEnabled', 'RdpGatewayEnabled', 'RdpProxyCertificateSecretId', 'RdpProxyEnabled', 'SecretWorkflowEnabled', 'SecurityAnalyticsEnabled', 'ServiceAccountManagementEnabled', 'SshProxyEnabled', 'SshTerminalEnabled'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = 'Settings'; Mandatory = @('TssSession', 'EngineSettingsId'); Optional = @('AdSyncEnabled', 'AdvancedAuditingEnabled', 'ExternalVaultsEnabled', 'FipsEnabled', 'LocalAccountDiscoveryEnabled', 'LogLevel', 'PasswordChangingEnabled', 'RdpGatewayEnabled', 'RdpProxyCertificateSecretId', 'RdpProxyEnabled', 'SecretWorkflowEnabled', 'SecurityAnalyticsEnabled', 'ServiceAccountManagementEnabled', 'SshProxyEnabled', 'SshTerminalEnabled'); Absent = @('EngineId') }
            @{ CommandName = $commandName; SetName = 'Engine'; Mandatory = @('TssSession', 'EngineId'); Optional = @('AdSyncEnabled', 'AdvancedAuditingEnabled', 'ExternalVaultsEnabled', 'FipsEnabled', 'LocalAccountDiscoveryEnabled', 'LogLevel', 'PasswordChangingEnabled', 'RdpGatewayEnabled', 'RdpProxyCertificateSecretId', 'RdpProxyEnabled', 'SecretWorkflowEnabled', 'SecurityAnalyticsEnabled', 'ServiceAccountManagementEnabled', 'SshProxyEnabled', 'SshTerminalEnabled'); Absent = @('EngineSettingsId') }
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
        It "$commandName should set OutputType to Thycotic.PowerShell.DistributedEngines.EngineSettings" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.DistributedEngines.EngineSettings'
        }
        It "$commandName should support ShouldProcess" -TestCases $commandDetails {
            $_.Parameters.ContainsKey('WhatIf') | Should -Be $true
        }
        It "$commandName should default to the Settings parameter set" -TestCases $commandDetails {
            $_.DefaultParameterSet | Should -Be 'Settings'
        }
        It "$commandName should take EngineSettingsId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['EngineSettingsId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take EngineId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['EngineId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take LogLevel as System.String" -TestCases $commandDetails {
            $_.Parameters['LogLevel'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take RdpProxyCertificateSecretId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['RdpProxyCertificateSecretId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take AdSyncEnabled as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['AdSyncEnabled'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take SshProxyEnabled as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['SshProxyEnabled'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take FipsEnabled as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['FipsEnabled'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should limit LogLevel to All,Debug,Info,Warn,Error,Off" -TestCases $commandDetails {
            (($_.Parameters['LogLevel'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('All,Debug,Info,Warn,Error,Off' -split ',') | Sort-Object) -join ',')
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
