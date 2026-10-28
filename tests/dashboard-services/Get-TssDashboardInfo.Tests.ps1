BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'NoHtmlEncode'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession'); Optional = @('NoHtmlEncode'); Absent = @() }
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
        It "$commandName should set OutputType to Thycotic.PowerShell.DashboardServices.DashboardInfo" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.DashboardServices.DashboardInfo'
        }
        It "$commandName should take TssSession as Thycotic.PowerShell.Authentication.Session" -TestCases $commandDetails {
            $_.Parameters['TssSession'].ParameterType.FullName | Should -Be 'Thycotic.PowerShell.Authentication.Session'
        }
        It "$commandName should take NoHtmlEncode as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['NoHtmlEncode'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take TssSession from the pipeline (ValueFromPipeline)" -TestCases $commandDetails {
            @($_.Parameters['TssSession'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] -and $_.ValueFromPipeline }).Count | Should -BeGreaterThan 0
        }
        It "$commandName should bind TssSession at position 0" -TestCases $commandDetails {
            @($_.Parameters['TssSession'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] }).Position | Should -Contain 0
        }
        It "$commandName pipeline/output type Thycotic.PowerShell.DashboardServices.DashboardInfo should expose ConfigurationSettings as System.Management.Automation.PSObject" {
            ([type]'Thycotic.PowerShell.DashboardServices.DashboardInfo').GetProperty('ConfigurationSettings').PropertyType.FullName | Should -Be 'System.Management.Automation.PSObject'
        }
        It "$commandName pipeline/output type Thycotic.PowerShell.DashboardServices.DashboardInfo should expose LastSelectedTab as Thycotic.PowerShell.DashboardServices.DashboardTab" {
            ([type]'Thycotic.PowerShell.DashboardServices.DashboardInfo').GetProperty('LastSelectedTab').PropertyType.FullName | Should -Be 'Thycotic.PowerShell.DashboardServices.DashboardTab'
        }
        It "$commandName pipeline/output type Thycotic.PowerShell.DashboardServices.DashboardInfo should expose SelectedTabWidgets as Thycotic.PowerShell.DashboardServices.DashboardWidget[]" {
            ([type]'Thycotic.PowerShell.DashboardServices.DashboardInfo').GetProperty('SelectedTabWidgets').PropertyType.FullName | Should -Be 'Thycotic.PowerShell.DashboardServices.DashboardWidget[]'
        }
        It "$commandName pipeline/output type Thycotic.PowerShell.DashboardServices.DashboardInfo should expose Tabs as Thycotic.PowerShell.DashboardServices.DashboardTab[]" {
            ([type]'Thycotic.PowerShell.DashboardServices.DashboardInfo').GetProperty('Tabs').PropertyType.FullName | Should -Be 'Thycotic.PowerShell.DashboardServices.DashboardTab[]'
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
