BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Autofill', 'AutoSubmit', 'CustomTemplateIds', 'InlinePopup', 'PromptToSave', 'PromptToUpdate', 'TemplateConfiguration', 'Type'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession', 'Type'); Optional = @('Autofill', 'AutoSubmit', 'CustomTemplateIds', 'InlinePopup', 'PromptToSave', 'PromptToUpdate', 'TemplateConfiguration'); Absent = @() }
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
        It "$commandName should set OutputType to Thycotic.PowerShell.Configuration.Dcm" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.Configuration.Dcm'
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
        It "$commandName should take Autofill as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['Autofill'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take AutoSubmit as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['AutoSubmit'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take CustomTemplateIds as System.Int32[]" -TestCases $commandDetails {
            $_.Parameters['CustomTemplateIds'].ParameterType.FullName | Should -Be 'System.Int32[]'
        }
        It "$commandName should take InlinePopup as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['InlinePopup'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take PromptToSave as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['PromptToSave'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take PromptToUpdate as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['PromptToUpdate'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take TemplateConfiguration as System.String" -TestCases $commandDetails {
            $_.Parameters['TemplateConfiguration'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take Type as System.String" -TestCases $commandDetails {
            $_.Parameters['Type'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should limit Type to BusinessUser,UnrestrictedUser" -TestCases $commandDetails {
            (($_.Parameters['Type'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('BusinessUser,UnrestrictedUser' -split ',') | Sort-Object) -join ',')
        }
        It "$commandName should limit TemplateConfiguration to Default,All,Custom" -TestCases $commandDetails {
            (($_.Parameters['TemplateConfiguration'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('Default,All,Custom' -split ',') | Sort-Object) -join ',')
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
