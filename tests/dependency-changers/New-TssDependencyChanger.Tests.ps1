BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Name', 'Description', 'DependencyTypeId', 'ScanItemTemplateId', 'Active', 'CreateDependencyTemplate', 'Setting', 'PasswordChangeScript', 'VerificationScript', 'ChangeSuccessScript', 'ChangeFailScript'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
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
        It "$commandName should set OutputType to Thycotic.PowerShell.DependencyChangers.DependencyChanger" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.DependencyChangers.DependencyChanger'
        }
        It "$commandName should support ShouldProcess" -TestCases $commandDetails {
            $_.Parameters.ContainsKey('WhatIf') | Should -Be $true
        }
        It "$commandName should set ConfirmImpact to Medium" -TestCases $commandDetails {
            ($_.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }).ConfirmImpact | Should -Be 'Medium'
        }
        It "$commandName should accept SecretDependencyChangerName as an alias of Name" -TestCases $commandDetails {
            $_.Parameters['Name'].Aliases | Should -Contain 'SecretDependencyChangerName'
        }
        It "$commandName should accept SecretDependencyChangerDescription as an alias of Description" -TestCases $commandDetails {
            $_.Parameters['Description'].Aliases | Should -Contain 'SecretDependencyChangerDescription'
        }
        It "$commandName should accept SecretDependencyTypeId as an alias of DependencyTypeId" -TestCases $commandDetails {
            $_.Parameters['DependencyTypeId'].Aliases | Should -Contain 'SecretDependencyTypeId'
        }
        It "$commandName should take Name as System.String" -TestCases $commandDetails {
            $_.Parameters['Name'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take Description as System.String" -TestCases $commandDetails {
            $_.Parameters['Description'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take DependencyTypeId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['DependencyTypeId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take ScanItemTemplateId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['ScanItemTemplateId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take Active as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['Active'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take CreateDependencyTemplate as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['CreateDependencyTemplate'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take Setting as System.Object[]" -TestCases $commandDetails {
            $_.Parameters['Setting'].ParameterType.FullName | Should -Be 'System.Object[]'
        }
        It "$commandName should take PasswordChangeScript as System.Object" -TestCases $commandDetails {
            $_.Parameters['PasswordChangeScript'].ParameterType.FullName | Should -Be 'System.Object'
        }
        It "$commandName should take VerificationScript as System.Object" -TestCases $commandDetails {
            $_.Parameters['VerificationScript'].ParameterType.FullName | Should -Be 'System.Object'
        }
        It "$commandName should take ChangeSuccessScript as System.Object" -TestCases $commandDetails {
            $_.Parameters['ChangeSuccessScript'].ParameterType.FullName | Should -Be 'System.Object'
        }
        It "$commandName should take ChangeFailScript as System.Object" -TestCases $commandDetails {
            $_.Parameters['ChangeFailScript'].ParameterType.FullName | Should -Be 'System.Object'
        }
    }
    BeforeDiscovery {
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession', 'Name', 'DependencyTypeId', 'ScanItemTemplateId', 'Setting'); Optional = @('Description', 'Active', 'CreateDependencyTemplate', 'PasswordChangeScript', 'VerificationScript', 'ChangeSuccessScript', 'ChangeFailScript'); Absent = @() }
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
