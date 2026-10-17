BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'EventPipelinePolicyId', 'EventEntityType', 'Name', 'Description', 'Active', 'TriggerActionId', 'Task', 'Filter'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession', 'EventEntityType', 'Name', 'TriggerActionId', 'Task'); Optional = @('EventPipelinePolicyId', 'Description', 'Active', 'Filter'); Absent = @() }
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
        It "$commandName should set OutputType to Thycotic.PowerShell.EventPipeline.List" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.EventPipeline.List'
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
        It "$commandName should take EventPipelinePolicyId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['EventPipelinePolicyId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take EventEntityType as Thycotic.PowerShell.Enums.EventEntityType" -TestCases $commandDetails {
            $_.Parameters['EventEntityType'].ParameterType.FullName | Should -Be 'Thycotic.PowerShell.Enums.EventEntityType'
        }
        It "$commandName should take Name as System.String" -TestCases $commandDetails {
            $_.Parameters['Name'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take Description as System.String" -TestCases $commandDetails {
            $_.Parameters['Description'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take Active as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['Active'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take TriggerActionId as System.Int32[]" -TestCases $commandDetails {
            $_.Parameters['TriggerActionId'].ParameterType.FullName | Should -Be 'System.Int32[]'
        }
        It "$commandName should take Task as System.Object[]" -TestCases $commandDetails {
            $_.Parameters['Task'].ParameterType.FullName | Should -Be 'System.Object[]'
        }
        It "$commandName should take Filter as System.Object[]" -TestCases $commandDetails {
            $_.Parameters['Filter'].ParameterType.FullName | Should -Be 'System.Object[]'
        }
        It "$commandName should accept PolicyId as an alias of EventPipelinePolicyId" -TestCases $commandDetails {
            $_.Parameters['EventPipelinePolicyId'].Aliases | Should -Contain 'PolicyId'
        }
        It "$commandName should accept EventEntityTypeId as an alias of EventEntityType" -TestCases $commandDetails {
            $_.Parameters['EventEntityType'].Aliases | Should -Contain 'EventEntityTypeId'
        }
        It "$commandName should accept EventPipelineName as an alias of Name" -TestCases $commandDetails {
            $_.Parameters['Name'].Aliases | Should -Contain 'EventPipelineName'
        }
        It "$commandName should accept EventPipelineDescription as an alias of Description" -TestCases $commandDetails {
            $_.Parameters['Description'].Aliases | Should -Contain 'EventPipelineDescription'
        }
        It "$commandName should accept EventActionId as an alias of TriggerActionId" -TestCases $commandDetails {
            $_.Parameters['TriggerActionId'].Aliases | Should -Contain 'EventActionId'
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
