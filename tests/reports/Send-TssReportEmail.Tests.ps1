BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id', 'EmailAddress', 'Format', 'Parameters', 'DateOptionId', 'TimeOptionId', 'TimeZoneOptionId'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession', 'Id', 'EmailAddress'); Optional = @('Format', 'Parameters', 'DateOptionId', 'TimeOptionId', 'TimeZoneOptionId'); Absent = @() }
        )
        $typeCases = @(@{ CommandName = $commandName; Parameter = 'DateOptionId'; TypeName = 'System.Int32' }, @{ CommandName = $commandName; Parameter = 'Id'; TypeName = 'System.Int32' }, @{ CommandName = $commandName; Parameter = 'Parameters'; TypeName = 'System.Collections.Hashtable' }, @{ CommandName = $commandName; Parameter = 'TimeOptionId'; TypeName = 'System.Int32' }, @{ CommandName = $commandName; Parameter = 'TimeZoneOptionId'; TypeName = 'System.String' })
        $aliasCases = @(@{ CommandName = $commandName; Parameter = 'Id'; Alias = @('ReportId') })
        $pipeCases = @(@{ CommandName = $commandName; Parameter = 'Id' })
        $validateSetCases = @(@{ CommandName = $commandName; Parameter = 'Format'; Values = @('Html', 'Csv') })
        $outputCases = @(@{ CommandName = $commandName; SetName = '*'; TypeName = 'System.Boolean' })
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
        It "$commandName should set OutputType to System.Boolean" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'System.Boolean'
        }
        It "$commandName should support ShouldProcess" -TestCases $commandDetails {
            $_.Parameters.ContainsKey('WhatIf') | Should -Be $true
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
    Context "Allowed values" {
        It "<Parameter> should accept exactly <Values>" -TestCases $validateSetCases {
            $vs = (Get-Command $CommandName).Parameters[$Parameter].Attributes.Where({ $_ -is [System.Management.Automation.ValidateSetAttribute] })
            ($vs.ValidValues -join ',') | Should -BeExactly ($Values -join ',')
        }
    }
}