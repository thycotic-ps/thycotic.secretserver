BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id', 'Name', 'Enabled', 'DomainId', 'Synchronized', 'SynchronizeNow', 'AdGuid', 'IsPlatform', 'HasGroupOwners', 'OwnerUserId', 'OwnerUserName', 'OwnerGroupId', 'OwnerGroupName'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession', 'Id', 'Name'); Optional = @('Enabled', 'DomainId', 'Synchronized', 'SynchronizeNow', 'AdGuid', 'IsPlatform', 'HasGroupOwners', 'OwnerUserId', 'OwnerUserName', 'OwnerGroupId', 'OwnerGroupName'); Absent = @() }
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
        It "$commandName should set OutputType to Thycotic.PowerShell.Groups.Group" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.Groups.Group'
        }
        It "$commandName should support ShouldProcess" -TestCases $commandDetails {
            $_.Parameters.ContainsKey('WhatIf') | Should -Be $true
        }
        It "$commandName should take Id as System.Int32" -TestCases $commandDetails {
            $_.Parameters['Id'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take Name as System.String" -TestCases $commandDetails {
            $_.Parameters['Name'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take Enabled as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['Enabled'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take DomainId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['DomainId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take Synchronized as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['Synchronized'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take SynchronizeNow as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['SynchronizeNow'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take AdGuid as System.String" -TestCases $commandDetails {
            $_.Parameters['AdGuid'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take IsPlatform as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['IsPlatform'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take HasGroupOwners as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['HasGroupOwners'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take OwnerUserId as System.Int32[]" -TestCases $commandDetails {
            $_.Parameters['OwnerUserId'].ParameterType.FullName | Should -Be 'System.Int32[]'
        }
        It "$commandName should take OwnerUserName as System.String[]" -TestCases $commandDetails {
            $_.Parameters['OwnerUserName'].ParameterType.FullName | Should -Be 'System.String[]'
        }
        It "$commandName should take OwnerGroupId as System.Int32[]" -TestCases $commandDetails {
            $_.Parameters['OwnerGroupId'].ParameterType.FullName | Should -Be 'System.Int32[]'
        }
        It "$commandName should take OwnerGroupName as System.String[]" -TestCases $commandDetails {
            $_.Parameters['OwnerGroupName'].ParameterType.FullName | Should -Be 'System.String[]'
        }
        It "$commandName should accept GroupId as an alias of Id" -TestCases $commandDetails {
            $_.Parameters['Id'].Aliases | Should -Contain 'GroupId'
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
