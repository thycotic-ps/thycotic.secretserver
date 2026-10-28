BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id', 'UsePowerShellCore', 'SqlDatabase', 'SqlPort', 'SqlPasswordChangerId', 'SqlParameter', 'SshPort', 'SshLineEnding', 'SshDoNotUseEnvironment', 'SshParameter'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = 'powershell'; Mandatory = @('TssSession', 'Id'); Optional = @('UsePowerShellCore'); Absent = @('SqlDatabase', 'SqlPort', 'SqlPasswordChangerId', 'SqlParameter', 'SshPort', 'SshLineEnding', 'SshDoNotUseEnvironment', 'SshParameter') }
            @{ CommandName = $commandName; SetName = 'sql'; Mandatory = @('TssSession', 'Id'); Optional = @('SqlDatabase', 'SqlPort', 'SqlPasswordChangerId', 'SqlParameter'); Absent = @('UsePowerShellCore', 'SshPort', 'SshLineEnding', 'SshDoNotUseEnvironment', 'SshParameter') }
            @{ CommandName = $commandName; SetName = 'ssh'; Mandatory = @('TssSession', 'Id'); Optional = @('SshPort', 'SshLineEnding', 'SshDoNotUseEnvironment', 'SshParameter'); Absent = @('UsePowerShellCore', 'SqlDatabase', 'SqlPort', 'SqlPasswordChangerId', 'SqlParameter') }
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
        It "$commandName should set OutputType to Thycotic.PowerShell.Scripts.ScriptItem" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.Scripts.ScriptItem'
        }
        It "$commandName should support ShouldProcess" -TestCases $commandDetails {
            $_.Parameters.ContainsKey('WhatIf') | Should -Be $true
        }
        It "$commandName should set ConfirmImpact to Medium" -TestCases $commandDetails {
            ($_.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }).ConfirmImpact | Should -Be 'Medium'
        }
        It "$commandName should declare no default parameter set" -TestCases $commandDetails {
            $_.DefaultParameterSet | Should -BeNullOrEmpty
        }
        It "$commandName should take TssSession as Thycotic.PowerShell.Authentication.Session" -TestCases $commandDetails {
            $_.Parameters['TssSession'].ParameterType.FullName | Should -Be 'Thycotic.PowerShell.Authentication.Session'
        }
        It "$commandName should take Id as System.Int32" -TestCases $commandDetails {
            $_.Parameters['Id'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take UsePowerShellCore as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['UsePowerShellCore'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take SqlDatabase as System.String" -TestCases $commandDetails {
            $_.Parameters['SqlDatabase'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take SqlPort as System.Int32" -TestCases $commandDetails {
            $_.Parameters['SqlPort'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take SqlPasswordChangerId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['SqlPasswordChangerId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take SqlParameter as System.Object[]" -TestCases $commandDetails {
            $_.Parameters['SqlParameter'].ParameterType.FullName | Should -Be 'System.Object[]'
        }
        It "$commandName should take SshPort as System.Int32" -TestCases $commandDetails {
            $_.Parameters['SshPort'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take SshLineEnding as System.String" -TestCases $commandDetails {
            $_.Parameters['SshLineEnding'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take SshDoNotUseEnvironment as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['SshDoNotUseEnvironment'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take SshParameter as System.Object[]" -TestCases $commandDetails {
            $_.Parameters['SshParameter'].ParameterType.FullName | Should -Be 'System.Object[]'
        }
        It "$commandName should limit SshLineEnding to NewLine,CarriageReturn,CarriageReturnNewLine" -TestCases $commandDetails {
            (($_.Parameters['SshLineEnding'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('NewLine,CarriageReturn,CarriageReturnNewLine' -split ',') | Sort-Object) -join ',')
        }
        It "$commandName should accept ScriptId as an alias of Id" -TestCases $commandDetails {
            $_.Parameters['Id'].Aliases | Should -Contain 'ScriptId'
        }
        It "$commandName should take TssSession from the pipeline (ValueFromPipeline)" -TestCases $commandDetails {
            @($_.Parameters['TssSession'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] -and $_.ValueFromPipeline }).Count | Should -BeGreaterThan 0
        }
        It "$commandName should take Id from the pipeline (ValueFromPipelineByPropertyName)" -TestCases $commandDetails {
            @($_.Parameters['Id'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] -and $_.ValueFromPipelineByPropertyName }).Count | Should -BeGreaterThan 0
        }
        It "$commandName should bind TssSession at position 0" -TestCases $commandDetails {
            @($_.Parameters['TssSession'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] }).Position | Should -Contain 0
        }
        It "$commandName should reject a null SqlParameter" -TestCases $commandDetails {
            @($_.Parameters['SqlParameter'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateNotNullAttribute] }).Count | Should -Be 1
        }
        It "$commandName should reject a null SshParameter" -TestCases $commandDetails {
            @($_.Parameters['SshParameter'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateNotNullAttribute] }).Count | Should -Be 1
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
