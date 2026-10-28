BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id', 'Flags', 'FlagsV2'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
    }
    Context "Verify parameters" -Foreach @{currentParams = $currentParams} {
        It "$commandName should contain <_> parameter" -TestCases $knownParameters {
            $_ -in $currentParams | Should -Be $true
        }
        It "$commandName should not contain parameter: <_>" -TestCases $unknownParameters {
            $_ | Should -BeNullOrEmpty
        }
    }
    Context "Command specific details" {
        It "$commandName should set OutputType to Thycotic.PowerShell.Secrets.DetailState and Thycotic.PowerShell.Secrets.StateFlags" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.Secrets.DetailState', 'Thycotic.PowerShell.Secrets.StateFlags'
        }
    }
}

Describe "$commandName parameter sets" {
    Context "Set details" {
        It "$commandName should default to the state parameter set" -TestCases @{ CommandName = $commandName } {
            (Get-Command $CommandName).DefaultParameterSet | Should -Be 'state'
        }
    }
    BeforeDiscovery {
        $setCases = @(
            @{ CommandName = $commandName; SetName = 'state'; Mandatory = @('TssSession', 'Id'); Optional = @(); Absent = @('Flags', 'FlagsV2') }
            @{ CommandName = $commandName; SetName = 'flags'; Mandatory = @('TssSession', 'Id', 'Flags'); Optional = @(); Absent = @('FlagsV2') }
            @{ CommandName = $commandName; SetName = 'flagsV2'; Mandatory = @('TssSession', 'Id', 'FlagsV2'); Optional = @(); Absent = @('Flags') }
        )
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
