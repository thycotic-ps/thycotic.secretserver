BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id', 'Slug', 'OutFile', 'Comment', 'DoublelockPassword', 'ForceCheckin', 'IncludeInactive', 'TicketNumber', 'TicketSystemId', 'NoAutoCheckout', 'AutoCheckout', 'AutoCheckIn', 'AutoComment'
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
        It "$commandName should set OutputType to System.String" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'System.String'
        }
    }
}

Describe "$commandName parameter sets" {
    Context "Set details" {
        It "$commandName should default to the field parameter set" -TestCases @{ CommandName = $commandName } {
            (Get-Command $CommandName).DefaultParameterSet | Should -Be 'field'
        }
    }
    BeforeDiscovery {
        $setCases = @(
            @{ CommandName = $commandName; SetName = 'field'; Mandatory = @('TssSession', 'Id', 'Slug'); Optional = @('NoAutoCheckout', 'OutFile'); Absent = @('Comment', 'DoublelockPassword', 'ForceCheckIn', 'IncludeInactive', 'TicketNumber', 'TicketSystemId', 'AutoCheckout', 'AutoCheckIn', 'AutoComment') }
            @{ CommandName = $commandName; SetName = 'checkout'; Mandatory = @('TssSession', 'Id', 'Slug'); Optional = @('AutoCheckout', 'AutoCheckIn', 'AutoComment'); Absent = @('NoAutoCheckout', 'OutFile', 'Comment', 'DoublelockPassword', 'ForceCheckIn', 'IncludeInactive', 'TicketNumber', 'TicketSystemId') }
            @{ CommandName = $commandName; SetName = 'restricted'; Mandatory = @('TssSession', 'Id', 'Slug'); Optional = @('NoAutoCheckout', 'OutFile', 'Comment', 'DoublelockPassword', 'ForceCheckIn', 'IncludeInactive', 'TicketNumber', 'TicketSystemId'); Absent = @('AutoCheckout', 'AutoCheckIn', 'AutoComment') }
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
