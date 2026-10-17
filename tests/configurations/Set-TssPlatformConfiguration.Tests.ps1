BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'EnablePlatformAuditIntegration', 'EnablePlatformInventoryForwarding', 'EnablePlatformOnLoginPage', 'ForcePlatformOnlyLogin', 'OpenIdConnectClientId', 'OpenIdConnectClientSecret', 'OpenIdConnectEnabled', 'OpenIdConnectLoginUrl', 'OpenIdConnectLogoutUrl', 'PlatformTenantId', 'ProfileName', 'RequirePlatformMfa', 'SynchronizationIntervalDays', 'SynchronizationIntervalHours'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession'); Optional = @('EnablePlatformAuditIntegration', 'EnablePlatformInventoryForwarding', 'EnablePlatformOnLoginPage', 'ForcePlatformOnlyLogin', 'OpenIdConnectClientId', 'OpenIdConnectClientSecret', 'OpenIdConnectEnabled', 'OpenIdConnectLoginUrl', 'OpenIdConnectLogoutUrl', 'PlatformTenantId', 'ProfileName', 'RequirePlatformMfa', 'SynchronizationIntervalDays', 'SynchronizationIntervalHours'); Absent = @() }
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
        It "$commandName should set OutputType to Thycotic.PowerShell.Configuration.PlatformConfiguration" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.Configuration.PlatformConfiguration'
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
        It "$commandName should take EnablePlatformAuditIntegration as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['EnablePlatformAuditIntegration'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take EnablePlatformInventoryForwarding as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['EnablePlatformInventoryForwarding'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take EnablePlatformOnLoginPage as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['EnablePlatformOnLoginPage'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take ForcePlatformOnlyLogin as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['ForcePlatformOnlyLogin'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take OpenIdConnectClientId as System.String" -TestCases $commandDetails {
            $_.Parameters['OpenIdConnectClientId'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take OpenIdConnectClientSecret as System.Security.SecureString" -TestCases $commandDetails {
            $_.Parameters['OpenIdConnectClientSecret'].ParameterType.FullName | Should -Be 'System.Security.SecureString'
        }
        It "$commandName should take OpenIdConnectEnabled as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['OpenIdConnectEnabled'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take OpenIdConnectLoginUrl as System.String" -TestCases $commandDetails {
            $_.Parameters['OpenIdConnectLoginUrl'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take OpenIdConnectLogoutUrl as System.String" -TestCases $commandDetails {
            $_.Parameters['OpenIdConnectLogoutUrl'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take PlatformTenantId as System.String" -TestCases $commandDetails {
            $_.Parameters['PlatformTenantId'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take ProfileName as System.String" -TestCases $commandDetails {
            $_.Parameters['ProfileName'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take RequirePlatformMfa as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['RequirePlatformMfa'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take SynchronizationIntervalDays as System.Int32" -TestCases $commandDetails {
            $_.Parameters['SynchronizationIntervalDays'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take SynchronizationIntervalHours as System.Int32" -TestCases $commandDetails {
            $_.Parameters['SynchronizationIntervalHours'].ParameterType.FullName | Should -Be 'System.Int32'
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
