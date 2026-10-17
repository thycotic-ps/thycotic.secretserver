BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'BaseScannerId', 'CommandSetId', 'ConcurrencyId', 'InputScanItemTemplateId', 'IsActive', 'ItemScannerDescription', 'ItemScannerName', 'OutputScanItemTemplateId', 'ScanTypeId', 'ScriptArguments', 'ScriptId'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession', 'BaseScannerId', 'InputScanItemTemplateId', 'ItemScannerName', 'OutputScanItemTemplateId', 'ScanTypeId'); Optional = @('CommandSetId', 'ConcurrencyId', 'IsActive', 'ItemScannerDescription', 'ScriptArguments', 'ScriptId'); Absent = @() }
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
        It "$commandName should set OutputType to Thycotic.PowerShell.Discovery.Scanner" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.Discovery.Scanner'
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
        It "$commandName should take BaseScannerId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['BaseScannerId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take CommandSetId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['CommandSetId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take ConcurrencyId as System.String" -TestCases $commandDetails {
            $_.Parameters['ConcurrencyId'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take InputScanItemTemplateId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['InputScanItemTemplateId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take IsActive as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['IsActive'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take ItemScannerDescription as System.String" -TestCases $commandDetails {
            $_.Parameters['ItemScannerDescription'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take ItemScannerName as System.String" -TestCases $commandDetails {
            $_.Parameters['ItemScannerName'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take OutputScanItemTemplateId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['OutputScanItemTemplateId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take ScanTypeId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['ScanTypeId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take ScriptArguments as System.String" -TestCases $commandDetails {
            $_.Parameters['ScriptArguments'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take ScriptId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['ScriptId'].ParameterType.FullName | Should -Be 'System.Int32'
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
