BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'ReportName', 'ReportId', 'Parameters', 'Delimiter', 'Format', 'Download'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = 'export'; Mandatory = @('TssSession'); Optional = @('ReportId', 'ReportName', 'Parameters', 'Delimiter', 'Format'); Absent = @('Download') }
            @{ CommandName = $commandName; SetName = 'download'; Mandatory = @('TssSession', 'Download'); Optional = @('ReportId', 'ReportName', 'Parameters', 'Delimiter', 'Format'); Absent = @() }
        )
        $typeCases = @(@{ CommandName = $commandName; Parameter = 'Download'; TypeName = 'System.Management.Automation.SwitchParameter' }, @{ CommandName = $commandName; Parameter = 'Parameters'; TypeName = 'System.Collections.Hashtable' }, @{ CommandName = $commandName; Parameter = 'ReportId'; TypeName = 'System.Int32' })
        $aliasCases = @(@{ CommandName = $commandName; Parameter = 'ReportId'; Alias = @('Id') })
        $pipeCases = @()
        $validateSetCases = @(@{ CommandName = $commandName; Parameter = 'Format'; Values = @('csv') })
        $outputCases = @(@{ CommandName = $commandName; SetName = '*'; TypeName = 'System.String' })
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
        It "$commandName should set OutputType to System.String" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'System.String'
        }
        It "$commandName should not support ShouldProcess" -TestCases $commandDetails {
            $_.Parameters.ContainsKey('WhatIf') | Should -Be $false
        }
        It "$commandName should default to the export parameter set" -TestCases $commandDetails {
            $_.DefaultParameterSet | Should -Be 'export'
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
    Context "Parameter types" {
        It "<Parameter> should be <TypeName>" -TestCases $typeCases {
            (Get-Command $CommandName).Parameters[$Parameter].ParameterType.FullName | Should -BeExactly $TypeName
        }
    }
    Context "Pipeline binding" {
        It "<Parameter> should carry alias <Alias>" -TestCases $aliasCases {
            foreach ($a in $Alias) {
                (Get-Command $CommandName).Parameters[$Parameter].Aliases | Should -Contain $a
            }
        }
    }
    Context "Allowed values" {
        It "<Parameter> should accept exactly <Values>" -TestCases $validateSetCases {
            $vs = (Get-Command $CommandName).Parameters[$Parameter].Attributes.Where({ $_ -is [System.Management.Automation.ValidateSetAttribute] })
            ($vs.ValidValues -join ',') | Should -BeExactly ($Values -join ',')
        }
    }
}