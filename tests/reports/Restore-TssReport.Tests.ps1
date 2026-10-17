BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession', 'Id'); Optional = @(); Absent = @() }
        )
        $typeCases = @(@{ CommandName = $commandName; Parameter = 'Id'; TypeName = 'System.Int32[]' })
        $aliasCases = @(@{ CommandName = $commandName; Parameter = 'Id'; Alias = @('ReportId') })
        $pipeCases = @(@{ CommandName = $commandName; Parameter = 'Id' })
        $validateSetCases = @()
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
}