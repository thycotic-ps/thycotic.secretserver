BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'EntityId', 'EntityType', 'RecurringScheduleType', 'Active', 'Duration', 'DurationStartDate', 'TimeZoneId', 'Notes', 'ScheduleConstraint'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession', 'EntityId', 'RecurringScheduleType', 'ScheduleConstraint'); Optional = @('EntityType', 'Active', 'Duration', 'DurationStartDate', 'TimeZoneId', 'Notes'); Absent = @() }
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
        It "$commandName should set OutputType to Thycotic.PowerShell.Schedules.Schedule" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.Schedules.Schedule'
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
        It "$commandName should take EntityId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['EntityId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take EntityType as System.String" -TestCases $commandDetails {
            $_.Parameters['EntityType'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take RecurringScheduleType as System.String" -TestCases $commandDetails {
            $_.Parameters['RecurringScheduleType'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take Active as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['Active'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take Duration as System.Int32" -TestCases $commandDetails {
            $_.Parameters['Duration'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take DurationStartDate as System.DateTime" -TestCases $commandDetails {
            $_.Parameters['DurationStartDate'].ParameterType.FullName | Should -Be 'System.DateTime'
        }
        It "$commandName should take TimeZoneId as System.String" -TestCases $commandDetails {
            $_.Parameters['TimeZoneId'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take Notes as System.String" -TestCases $commandDetails {
            $_.Parameters['Notes'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take ScheduleConstraint as System.Object[]" -TestCases $commandDetails {
            $_.Parameters['ScheduleConstraint'].ParameterType.FullName | Should -Be 'System.Object[]'
        }
        It "$commandName should limit EntityType to InboxRule" -TestCases $commandDetails {
            (($_.Parameters['EntityType'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('InboxRule' -split ',') | Sort-Object) -join ',')
        }
        It "$commandName should limit RecurringScheduleType to Daily,Weekly,MonthlyDays,MonthlyWeeks" -TestCases $commandDetails {
            (($_.Parameters['RecurringScheduleType'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('Daily,Weekly,MonthlyDays,MonthlyWeeks' -split ',') | Sort-Object) -join ',')
        }
        It "$commandName should default EntityType to InboxRule" -TestCases $commandDetails {
            ($_.ScriptBlock.Ast.Body.ParamBlock.Parameters | Where-Object { $_.Name.VariablePath.UserPath -eq 'EntityType' }).DefaultValue.SafeGetValue() | Should -BeExactly 'InboxRule'
        }
        It "$commandName should default Duration to 1" -TestCases $commandDetails {
            ($_.ScriptBlock.Ast.Body.ParamBlock.Parameters | Where-Object { $_.Name.VariablePath.UserPath -eq 'Duration' }).DefaultValue.SafeGetValue() | Should -BeExactly '1'
        }
        It "$commandName should default TimeZoneId to UTC" -TestCases $commandDetails {
            ($_.ScriptBlock.Ast.Body.ParamBlock.Parameters | Where-Object { $_.Name.VariablePath.UserPath -eq 'TimeZoneId' }).DefaultValue.SafeGetValue() | Should -BeExactly 'UTC'
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
