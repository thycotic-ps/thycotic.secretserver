BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'InboxRuleId', 'InboxDataId', 'Operand', 'ValueString', 'ValueInt', 'ValueBool', 'ValueDateTime', 'DisplayValue'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession', 'InboxRuleId', 'InboxDataId'); Optional = @('Operand', 'ValueString', 'ValueInt', 'ValueBool', 'ValueDateTime', 'DisplayValue'); Absent = @() }
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
        It "$commandName should support ShouldProcess" -TestCases $commandDetails {
            $_.Parameters.ContainsKey('WhatIf') | Should -Be $true
        }
        It "$commandName should set ConfirmImpact to Medium" -TestCases $commandDetails {
            ($_.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }).ConfirmImpact | Should -Be 'Medium'
        }
        It "$commandName should take TssSession as Thycotic.PowerShell.Authentication.Session" -TestCases $commandDetails {
            $_.Parameters['TssSession'].ParameterType.FullName | Should -Be 'Thycotic.PowerShell.Authentication.Session'
        }
        It "$commandName should take InboxRuleId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['InboxRuleId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take InboxDataId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['InboxDataId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take Operand as System.String" -TestCases $commandDetails {
            $_.Parameters['Operand'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take ValueString as System.String" -TestCases $commandDetails {
            $_.Parameters['ValueString'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take ValueInt as System.Int32" -TestCases $commandDetails {
            $_.Parameters['ValueInt'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take ValueBool as System.Boolean" -TestCases $commandDetails {
            $_.Parameters['ValueBool'].ParameterType.FullName | Should -Be 'System.Boolean'
        }
        It "$commandName should take ValueDateTime as System.DateTime" -TestCases $commandDetails {
            $_.Parameters['ValueDateTime'].ParameterType.FullName | Should -Be 'System.DateTime'
        }
        It "$commandName should take DisplayValue as System.String" -TestCases $commandDetails {
            $_.Parameters['DisplayValue'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should limit Operand to Equals,NotEquals,LessThan,GreaterThan,Regex" -TestCases $commandDetails {
            (($_.Parameters['Operand'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('Equals,NotEquals,LessThan,GreaterThan,Regex' -split ',') | Sort-Object) -join ',')
        }
        It "$commandName should default Operand to Equals" -TestCases $commandDetails {
            ($_.ScriptBlock.Ast.Body.ParamBlock.Parameters | Where-Object { $_.Name.VariablePath.UserPath -eq 'Operand' }).DefaultValue.SafeGetValue() | Should -BeExactly 'Equals'
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
