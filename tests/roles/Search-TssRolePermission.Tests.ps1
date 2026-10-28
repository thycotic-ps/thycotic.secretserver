BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id', 'Eligible', 'Unassigned'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = 'Default'; Mandatory = @('TssSession', 'Id'); Optional = @(); Absent = @('Eligible', 'Unassigned') }
            @{ CommandName = $commandName; SetName = 'Eligible'; Mandatory = @('TssSession', 'Id', 'Eligible'); Optional = @(); Absent = @('Unassigned') }
            @{ CommandName = $commandName; SetName = 'Unassigned'; Mandatory = @('TssSession', 'Id', 'Unassigned'); Optional = @(); Absent = @('Eligible') }
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
        It "$commandName should set OutputType to Thycotic.PowerShell.Roles.Permission[]" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.Roles.Permission[]'
        }
        It "$commandName should default to the Default parameter set" -TestCases $commandDetails {
            $_.DefaultParameterSet | Should -Be 'Default'
        }
        It "$commandName should take Id as System.Int32[]" -TestCases $commandDetails {
            $_.Parameters['Id'].ParameterType.FullName | Should -Be 'System.Int32[]'
        }
        It "$commandName should take Eligible as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['Eligible'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take Unassigned as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['Unassigned'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should accept RoleId as an alias of Id" -TestCases $commandDetails {
            $_.Parameters['Id'].Aliases | Should -Contain 'RoleId'
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
