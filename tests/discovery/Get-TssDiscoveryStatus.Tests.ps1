BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'ItemMetrics', 'OsMetrics', 'ScanResults'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
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
        It "$commandName should include OutputType Thycotic.PowerShell.Discovery.Status" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Contain 'Thycotic.PowerShell.Discovery.Status'
        }
        It "$commandName should include OutputType <TypeName>" -TestCases @(@{ CommandName = $commandName; TypeName = 'Thycotic.PowerShell.Discovery.StatusItemMetric[]' }, @{ CommandName = $commandName; TypeName = 'Thycotic.PowerShell.Discovery.StatusOsMetric[]' }, @{ CommandName = $commandName; TypeName = 'Thycotic.PowerShell.Discovery.StatusScanResult[]' }) {
            (Get-Command $CommandName).OutputType.Name | Should -Contain $TypeName
        }
        It "$commandName should default to the status parameter set" -TestCases $commandDetails {
            $_.DefaultParameterSet | Should -Be 'status'
        }
        It "$commandName should take <ParamName> as a switch" -TestCases @(@{ CommandName = $commandName; ParamName = 'ItemMetrics' }, @{ CommandName = $commandName; ParamName = 'OsMetrics' }, @{ CommandName = $commandName; ParamName = 'ScanResults' }) {
            (Get-Command $CommandName).Parameters[$ParamName].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take TssSession from the pipeline at position 0" -TestCases $commandDetails {
            $attr = @($_.Parameters['TssSession'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] })
            @($attr | Where-Object ValueFromPipeline).Count | Should -BeGreaterThan 0
            $attr.Position | Should -Contain 0
        }
    }
    Context "Parameter set <SetName>" -Foreach @(
        @{ CommandName = $commandName; SetName = 'status'; Mandatory = @('TssSession') }
        @{ CommandName = $commandName; SetName = 'itemMetrics'; Mandatory = @('ItemMetrics', 'TssSession') }
        @{ CommandName = $commandName; SetName = 'osMetrics'; Mandatory = @('OsMetrics', 'TssSession') }
        @{ CommandName = $commandName; SetName = 'scanResults'; Mandatory = @('ScanResults', 'TssSession') }
    ) {
        BeforeAll {
            $set = (Get-Command $CommandName).ParameterSets.Where({ $_.Name -eq $SetName })[0]
        }
        It "should exist" {
            $set | Should -Not -BeNullOrEmpty
        }
        It "should require exactly <Mandatory> and offer nothing else" {
            $common = [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
            ($set.Parameters.Where({ $_.IsMandatory }).Name | Sort-Object) -join ',' | Should -BeExactly (($Mandatory | Sort-Object) -join ',')
            @($set.Parameters.Where({ -not $_.IsMandatory -and $_.Name -notin $common })).Count | Should -Be 0
        }
    }
}