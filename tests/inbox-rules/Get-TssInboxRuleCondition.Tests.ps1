BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'InboxRuleId', 'Id'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = 'rule'; Mandatory = @('TssSession', 'InboxRuleId'); Optional = @(); Absent = @('Id') }
            @{ CommandName = $commandName; SetName = 'condition'; Mandatory = @('TssSession', 'Id'); Optional = @(); Absent = @('InboxRuleId') }
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
        It "$commandName should set OutputType to Thycotic.PowerShell.InboxRules.Condition" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.InboxRules.Condition'
        }
        It "$commandName should default to the rule parameter set" -TestCases $commandDetails {
            $_.DefaultParameterSet | Should -Be 'rule'
        }
        It "$commandName should take TssSession as Thycotic.PowerShell.Authentication.Session" -TestCases $commandDetails {
            $_.Parameters['TssSession'].ParameterType.FullName | Should -Be 'Thycotic.PowerShell.Authentication.Session'
        }
        It "$commandName should take InboxRuleId as System.Int32[]" -TestCases $commandDetails {
            $_.Parameters['InboxRuleId'].ParameterType.FullName | Should -Be 'System.Int32[]'
        }
        It "$commandName should take Id as System.Int32[]" -TestCases $commandDetails {
            $_.Parameters['Id'].ParameterType.FullName | Should -Be 'System.Int32[]'
        }
        It "$commandName should accept InboxRuleConditionId as an alias of Id" -TestCases $commandDetails {
            $_.Parameters['Id'].Aliases | Should -Contain 'InboxRuleConditionId'
        }
        It "$commandName should take TssSession from the pipeline (ValueFromPipeline)" -TestCases $commandDetails {
            @($_.Parameters['TssSession'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] -and $_.ValueFromPipeline }).Count | Should -BeGreaterThan 0
        }
        It "$commandName should take InboxRuleId from the pipeline (ValueFromPipelineByPropertyName)" -TestCases $commandDetails {
            @($_.Parameters['InboxRuleId'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] -and $_.ValueFromPipelineByPropertyName }).Count | Should -BeGreaterThan 0
        }
        It "$commandName should bind TssSession at position 0" -TestCases $commandDetails {
            @($_.Parameters['TssSession'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] }).Position | Should -Contain 0
        }
        It "$commandName pipeline/output type Thycotic.PowerShell.InboxRules.Condition should expose InboxRuleConditionId as System.Int32" {
            ([type]'Thycotic.PowerShell.InboxRules.Condition').GetProperty('InboxRuleConditionId').PropertyType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName pipeline/output type Thycotic.PowerShell.InboxRules.Condition should expose InboxRuleId as System.Int32" {
            ([type]'Thycotic.PowerShell.InboxRules.Condition').GetProperty('InboxRuleId').PropertyType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName pipeline/output type Thycotic.PowerShell.InboxRules.Condition should expose InboxRuleOperand as System.String" {
            ([type]'Thycotic.PowerShell.InboxRules.Condition').GetProperty('InboxRuleOperand').PropertyType.FullName | Should -Be 'System.String'
        }
        It "$commandName pipeline/output type Thycotic.PowerShell.InboxRules.Condition should expose ValueBool as a nullable System.Boolean" {
            [Nullable]::GetUnderlyingType(([type]'Thycotic.PowerShell.InboxRules.Condition').GetProperty('ValueBool').PropertyType).FullName | Should -Be 'System.Boolean'
        }
        It "$commandName pipeline/output type Thycotic.PowerShell.InboxRules.Condition should expose ValueInt as a nullable System.Int32" {
            [Nullable]::GetUnderlyingType(([type]'Thycotic.PowerShell.InboxRules.Condition').GetProperty('ValueInt').PropertyType).FullName | Should -Be 'System.Int32'
        }
        It "$commandName pipeline/output type Thycotic.PowerShell.InboxRules.Condition should expose ValueDateTime as a nullable System.DateTime" {
            [Nullable]::GetUnderlyingType(([type]'Thycotic.PowerShell.InboxRules.Condition').GetProperty('ValueDateTime').PropertyType).FullName | Should -Be 'System.DateTime'
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
