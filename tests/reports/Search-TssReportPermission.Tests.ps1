BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id', 'Options'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = 'report'; Mandatory = @('TssSession', 'Id'); Optional = @(); Absent = @('Options') }
            @{ CommandName = $commandName; SetName = 'options'; Mandatory = @('TssSession', 'Options'); Optional = @(); Absent = @('Id') }
        )
        $typeCases = @(@{ CommandName = $commandName; Parameter = 'Id'; TypeName = 'System.Int32[]' }, @{ CommandName = $commandName; Parameter = 'Options'; TypeName = 'System.Management.Automation.SwitchParameter' })
        $aliasCases = @(@{ CommandName = $commandName; Parameter = 'Id'; Alias = @('ReportId') })
        $pipeCases = @(@{ CommandName = $commandName; Parameter = 'Id' })
        $validateSetCases = @()
        $outputCases = @(@{ CommandName = $commandName; SetName = 'options'; TypeName = 'Thycotic.PowerShell.Reports.PermissionOption[]' }, @{ CommandName = $commandName; SetName = 'report'; TypeName = 'Thycotic.PowerShell.Reports.Permission[]' })
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
        It "$commandName should not support ShouldProcess" -TestCases $commandDetails {
            $_.Parameters.ContainsKey('WhatIf') | Should -Be $false
        }
        It "$commandName should default to the report parameter set" -TestCases $commandDetails {
            $_.DefaultParameterSet | Should -Be 'report'
        }
    }
    Context "Output type of set <SetName>" -Foreach $outputCases {
        It "should declare OutputType <TypeName> for set <SetName>" {
            $declared = (Get-Command $CommandName).ScriptBlock.Attributes.Where({ $_ -is [System.Management.Automation.OutputTypeAttribute] -and $SetName -in $_.ParameterSetName })
            ($declared.Type.Name -join ',') | Should -BeExactly $TypeName
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
        It "<Parameter> should bind from the pipeline by property name" -TestCases $pipeCases {
            $byName = (Get-Command $CommandName).Parameters[$Parameter].ParameterSets.Values.Where({ $_.ValueFromPipelineByPropertyName })
            $byName.Count | Should -BeGreaterThan 0
        }
    }
}