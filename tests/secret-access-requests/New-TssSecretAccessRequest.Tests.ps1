BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'ExpirationDate', 'RequestComment', 'SecretId', 'StartDate', 'TicketNumber', 'TicketSystemId', 'V2'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = 'Default'; Mandatory = @('TssSession', 'SecretId'); Optional = @('ExpirationDate', 'RequestComment', 'StartDate', 'TicketNumber', 'TicketSystemId'); Absent = @('V2') }
            @{ CommandName = $commandName; SetName = 'V2'; Mandatory = @('TssSession', 'SecretId', 'V2'); Optional = @('ExpirationDate', 'RequestComment', 'StartDate', 'TicketNumber', 'TicketSystemId'); Absent = @() }
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
        It "$commandName should set OutputType to Thycotic.PowerShell.AccessRequests.Request" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.AccessRequests.Request'
        }
        It "$commandName should support ShouldProcess" -TestCases $commandDetails {
            $_.Parameters.ContainsKey('WhatIf') | Should -Be $true
        }
        It "$commandName should set ConfirmImpact to Medium" -TestCases $commandDetails {
            ($_.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }).ConfirmImpact | Should -Be 'Medium'
        }
        It "$commandName should default to the Default parameter set" -TestCases $commandDetails {
            $_.DefaultParameterSet | Should -Be 'Default'
        }
        It "$commandName should take TssSession as Thycotic.PowerShell.Authentication.Session" -TestCases $commandDetails {
            $_.Parameters['TssSession'].ParameterType.FullName | Should -Be 'Thycotic.PowerShell.Authentication.Session'
        }
        It "$commandName should take ExpirationDate as System.DateTime" -TestCases $commandDetails {
            $_.Parameters['ExpirationDate'].ParameterType.FullName | Should -Be 'System.DateTime'
        }
        It "$commandName should take RequestComment as System.String" -TestCases $commandDetails {
            $_.Parameters['RequestComment'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take SecretId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['SecretId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take StartDate as System.DateTime" -TestCases $commandDetails {
            $_.Parameters['StartDate'].ParameterType.FullName | Should -Be 'System.DateTime'
        }
        It "$commandName should take TicketNumber as System.String" -TestCases $commandDetails {
            $_.Parameters['TicketNumber'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take TicketSystemId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['TicketSystemId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take V2 as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['V2'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
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
