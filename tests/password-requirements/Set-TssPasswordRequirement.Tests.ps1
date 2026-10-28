BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id', 'AllowedCharacterSetId', 'Description', 'DifokMinDifferentCharacters', 'EnforceDifok', 'IsDefault', 'MaxPasswordLength', 'MinimumRequiredCharacterSets', 'MinPasswordLength', 'Name', 'PasswordDictionaries', 'PreventDictionaryWords', 'PreventSequentialPattern', 'PreventSpatialPattern', 'PreventUsername'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession', 'Id'); Optional = @('AllowedCharacterSetId', 'Description', 'DifokMinDifferentCharacters', 'EnforceDifok', 'IsDefault', 'MaxPasswordLength', 'MinimumRequiredCharacterSets', 'MinPasswordLength', 'Name', 'PasswordDictionaries', 'PreventDictionaryWords', 'PreventSequentialPattern', 'PreventSpatialPattern', 'PreventUsername'); Absent = @() }
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
        It "$commandName should set OutputType to Thycotic.PowerShell.PasswordRequirements.PasswordRequirement" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.PasswordRequirements.PasswordRequirement'
        }
        It "$commandName should support ShouldProcess" -TestCases $commandDetails {
            $_.Parameters.ContainsKey('WhatIf') | Should -Be $true
        }
        It "$commandName should take Id as System.Int32" -TestCases $commandDetails {
            $_.Parameters['Id'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take AllowedCharacterSetId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['AllowedCharacterSetId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take DifokMinDifferentCharacters as System.Int32" -TestCases $commandDetails {
            $_.Parameters['DifokMinDifferentCharacters'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take EnforceDifok as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['EnforceDifok'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take IsDefault as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['IsDefault'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take MaxPasswordLength as System.Int32" -TestCases $commandDetails {
            $_.Parameters['MaxPasswordLength'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take MinimumRequiredCharacterSets as System.Int32" -TestCases $commandDetails {
            $_.Parameters['MinimumRequiredCharacterSets'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take MinPasswordLength as System.Int32" -TestCases $commandDetails {
            $_.Parameters['MinPasswordLength'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take Name as System.String" -TestCases $commandDetails {
            $_.Parameters['Name'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take PasswordDictionaries as System.Int32[]" -TestCases $commandDetails {
            $_.Parameters['PasswordDictionaries'].ParameterType.FullName | Should -Be 'System.Int32[]'
        }
        It "$commandName should take PreventDictionaryWords as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['PreventDictionaryWords'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take PreventSequentialPattern as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['PreventSequentialPattern'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take PreventSpatialPattern as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['PreventSpatialPattern'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take PreventUsername as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['PreventUsername'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should accept PasswordRequirementId as an alias of Id" -TestCases $commandDetails {
            $_.Parameters['Id'].Aliases | Should -Contain 'PasswordRequirementId'
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
