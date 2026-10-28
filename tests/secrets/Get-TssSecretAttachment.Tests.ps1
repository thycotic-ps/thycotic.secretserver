BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id', 'Slug', 'Path', 'Comment', 'ForceCheckIn', 'TicketNumber', 'TicketSystemId', 'NoAutoCheckout', 'OutFile'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = 'id'; Mandatory = @('TssSession', 'Id', 'Slug'); Optional = @('NoAutoCheckout', 'Comment', 'ForceCheckIn', 'TicketNumber', 'TicketSystemId'); Absent = @('Path', 'OutFile') }
            @{ CommandName = $commandName; SetName = 'path'; Mandatory = @('TssSession', 'Id', 'Slug', 'Path'); Optional = @('NoAutoCheckout', 'Comment', 'ForceCheckIn', 'TicketNumber', 'TicketSystemId'); Absent = @('OutFile') }
            @{ CommandName = $commandName; SetName = 'restricted'; Mandatory = @('TssSession', 'Slug'); Optional = @('Comment', 'ForceCheckIn', 'TicketNumber', 'TicketSystemId'); Absent = @('Id', 'Path', 'NoAutoCheckout', 'OutFile') }
            @{ CommandName = $commandName; SetName = 'outfile'; Mandatory = @('TssSession', 'Id', 'Slug', 'OutFile'); Optional = @(); Absent = @('Path', 'NoAutoCheckout', 'Comment', 'ForceCheckIn', 'TicketNumber', 'TicketSystemId') }
        )
    }
    Context "Verify parameters" -Foreach @{currentParams = $currentParams} {
        It "$commandName should contain <_> parameter" -TestCases $knownParameters {
            $_ -in $currentParams | Should -Be $true
        }
        It "$commandName should not contain parameter: <_>" -TestCases $unknownParameters {
            $_ | Should -BeNullOrEmpty
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
