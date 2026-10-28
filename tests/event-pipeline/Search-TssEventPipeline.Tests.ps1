BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'PipelinePolicyId', 'PipelineName', 'EventEntityType', 'IncludeInactive', 'ExcludeActive', 'SortBy', 'Detailed'
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
        It "$commandName should set OutputType to Thycotic.PowerShell.EventPipeline.Summary[] and Thycotic.PowerShell.EventPipeline.List[]" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.EventPipeline.Summary[]', 'Thycotic.PowerShell.EventPipeline.List[]'
        }
        It "$commandName should default to the summary parameter set" -TestCases $commandDetails {
            $_.DefaultParameterSet | Should -Be 'summary'
        }
        It "$commandName should require Detailed only in the detailed parameter set" -TestCases $commandDetails {
            ($_.ParameterSets | Where-Object { $_.Name -eq 'detailed' }).Parameters.Where({ $_.Name -eq 'Detailed' }).IsMandatory | Should -Be $true
            ($_.ParameterSets | Where-Object { $_.Name -eq 'summary' }).Parameters.Name | Should -Not -Contain 'Detailed'
        }
    }
}