BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'AdminEmail', 'AdminUsername', 'IsPlatformRegionEditable', 'OptIn', 'PlatformRegion', 'TenantName'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession', 'AdminEmail', 'AdminUsername', 'PlatformRegion', 'TenantName'); Optional = @('IsPlatformRegionEditable', 'OptIn'); Absent = @() }
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
        It "$commandName should set OutputType to Thycotic.PowerShell.Platform.ProvisionStatus" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.Platform.ProvisionStatus'
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
        It "$commandName should take AdminEmail as System.String" -TestCases $commandDetails {
            $_.Parameters['AdminEmail'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take AdminUsername as System.String" -TestCases $commandDetails {
            $_.Parameters['AdminUsername'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take IsPlatformRegionEditable as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['IsPlatformRegionEditable'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take OptIn as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['OptIn'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take PlatformRegion as System.String" -TestCases $commandDetails {
            $_.Parameters['PlatformRegion'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take TenantName as System.String" -TestCases $commandDetails {
            $_.Parameters['TenantName'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should accept OptinToPlatformAcknowledgement as an alias of OptIn" -TestCases $commandDetails {
            $_.Parameters['OptIn'].Aliases | Should -Contain 'OptinToPlatformAcknowledgement'
        }
        It "$commandName should take TssSession from the pipeline (ValueFromPipeline)" -TestCases $commandDetails {
            @($_.Parameters['TssSession'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] -and $_.ValueFromPipeline }).Count | Should -BeGreaterThan 0
        }
        It "$commandName should bind TssSession at position 0" -TestCases $commandDetails {
            @($_.Parameters['TssSession'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] }).Position | Should -Contain 0
        }
        It "$commandName pipeline/output type Thycotic.PowerShell.Platform.Region should expose Id as System.String" {
            ([type]'Thycotic.PowerShell.Platform.Region').GetProperty('Id').PropertyType.FullName | Should -Be 'System.String'
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
