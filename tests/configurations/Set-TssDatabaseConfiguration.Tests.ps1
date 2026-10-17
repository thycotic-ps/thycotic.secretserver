BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'AuthenticationType', 'ConnectionTimeout', 'DatabaseName', 'EnableMultiSubnetFailover', 'EnableSslEncryption', 'FailoverPartner', 'FileOverridePassword', 'FileOverrideUserName', 'Password', 'ServerName', 'TrustServerCertificate', 'UserName'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession'); Optional = @('AuthenticationType', 'ConnectionTimeout', 'DatabaseName', 'EnableMultiSubnetFailover', 'EnableSslEncryption', 'FailoverPartner', 'FileOverridePassword', 'FileOverrideUserName', 'Password', 'ServerName', 'TrustServerCertificate', 'UserName'); Absent = @() }
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
        It "$commandName should set OutputType to Thycotic.PowerShell.Configuration.DatabaseConfiguration" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.Configuration.DatabaseConfiguration'
        }
        It "$commandName should support ShouldProcess" -TestCases $commandDetails {
            $_.Parameters.ContainsKey('WhatIf') | Should -Be $true
        }
        It "$commandName should set ConfirmImpact to High" -TestCases $commandDetails {
            ($_.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }).ConfirmImpact | Should -Be 'High'
        }
        It "$commandName should take TssSession as Thycotic.PowerShell.Authentication.Session" -TestCases $commandDetails {
            $_.Parameters['TssSession'].ParameterType.FullName | Should -Be 'Thycotic.PowerShell.Authentication.Session'
        }
        It "$commandName should take AuthenticationType as System.String" -TestCases $commandDetails {
            $_.Parameters['AuthenticationType'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take ConnectionTimeout as System.Int32" -TestCases $commandDetails {
            $_.Parameters['ConnectionTimeout'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take DatabaseName as System.String" -TestCases $commandDetails {
            $_.Parameters['DatabaseName'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take EnableMultiSubnetFailover as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['EnableMultiSubnetFailover'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take EnableSslEncryption as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['EnableSslEncryption'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take FailoverPartner as System.String" -TestCases $commandDetails {
            $_.Parameters['FailoverPartner'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take FileOverridePassword as System.Security.SecureString" -TestCases $commandDetails {
            $_.Parameters['FileOverridePassword'].ParameterType.FullName | Should -Be 'System.Security.SecureString'
        }
        It "$commandName should take FileOverrideUserName as System.String" -TestCases $commandDetails {
            $_.Parameters['FileOverrideUserName'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take Password as System.Security.SecureString" -TestCases $commandDetails {
            $_.Parameters['Password'].ParameterType.FullName | Should -Be 'System.Security.SecureString'
        }
        It "$commandName should take ServerName as System.String" -TestCases $commandDetails {
            $_.Parameters['ServerName'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take TrustServerCertificate as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['TrustServerCertificate'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take UserName as System.String" -TestCases $commandDetails {
            $_.Parameters['UserName'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should limit AuthenticationType to WindowsAuth,SqlAuth,AADIntegrated,AADSqlAuth,ManagedIdentity" -TestCases $commandDetails {
            (($_.Parameters['AuthenticationType'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('WindowsAuth,SqlAuth,AADIntegrated,AADSqlAuth,ManagedIdentity' -split ',') | Sort-Object) -join ',')
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
