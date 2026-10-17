BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id', 'Name', 'Active', 'CustomPort', 'LineEnding', 'UseUsernameAndPassword', 'IgnoreSSL', 'UseSSL', 'ValidForTakeover', 'RequestTerminal', 'RunnerType', 'ExitCommand', 'WindowsCustomPorts', 'OdbcConnectionString', 'MainframeConnectionString', 'RpcScriptId', 'RpcScriptArgs', 'HeartbeatScriptId', 'HeartbeatScriptArgs', 'PasswordType'
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
        It "$commandName should set OutputType to Thycotic.PowerShell.Rpc.PasswordType" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.Rpc.PasswordType'
        }
        It "$commandName should support ShouldProcess" -TestCases $commandDetails {
            $_.Parameters.ContainsKey('WhatIf') | Should -Be $true
        }
        It "$commandName should set ConfirmImpact to Medium" -TestCases $commandDetails {
            ($_.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }).ConfirmImpact | Should -Be 'Medium'
        }
        It "$commandName should default to the object parameter set" -TestCases $commandDetails {
            $_.DefaultParameterSet | Should -Be 'object'
        }
        It "$commandName should accept PasswordTypeId as an alias of Id" -TestCases $commandDetails {
            $_.Parameters['Id'].Aliases | Should -Contain 'PasswordTypeId'
        }
        It "$commandName should take Id from the pipeline by property name" -TestCases $commandDetails {
            @($_.Parameters['Id'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] -and $_.ValueFromPipelineByPropertyName }).Count | Should -BeGreaterThan 0
        }
        It "$commandName should take Id as System.Int32" -TestCases $commandDetails {
            $_.Parameters['Id'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take Name as System.String" -TestCases $commandDetails {
            $_.Parameters['Name'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take Active as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['Active'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take CustomPort as System.Int32" -TestCases $commandDetails {
            $_.Parameters['CustomPort'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take LineEnding as System.String" -TestCases $commandDetails {
            $_.Parameters['LineEnding'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take UseUsernameAndPassword as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['UseUsernameAndPassword'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take IgnoreSSL as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['IgnoreSSL'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take UseSSL as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['UseSSL'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take ValidForTakeover as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['ValidForTakeover'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take RequestTerminal as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['RequestTerminal'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take RunnerType as System.String" -TestCases $commandDetails {
            $_.Parameters['RunnerType'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take ExitCommand as System.String" -TestCases $commandDetails {
            $_.Parameters['ExitCommand'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take WindowsCustomPorts as System.String" -TestCases $commandDetails {
            $_.Parameters['WindowsCustomPorts'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take OdbcConnectionString as System.String" -TestCases $commandDetails {
            $_.Parameters['OdbcConnectionString'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take MainframeConnectionString as System.String" -TestCases $commandDetails {
            $_.Parameters['MainframeConnectionString'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take RpcScriptId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['RpcScriptId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take RpcScriptArgs as System.String" -TestCases $commandDetails {
            $_.Parameters['RpcScriptArgs'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take HeartbeatScriptId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['HeartbeatScriptId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take HeartbeatScriptArgs as System.String" -TestCases $commandDetails {
            $_.Parameters['HeartbeatScriptArgs'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take PasswordType as Thycotic.PowerShell.Rpc.PasswordType[]" -TestCases $commandDetails {
            $_.Parameters['PasswordType'].ParameterType.FullName | Should -Be 'Thycotic.PowerShell.Rpc.PasswordType[]'
        }
        It "$commandName should limit LineEnding to NewLine,CarriageReturn,CarriageReturnNewLine" -TestCases $commandDetails {
            (($_.Parameters['LineEnding'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('NewLine,CarriageReturn,CarriageReturnNewLine' -split ',') | Sort-Object) -join ',')
        }
        It "$commandName should limit RunnerType to Standard,Legacy" -TestCases $commandDetails {
            (($_.Parameters['RunnerType'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('Standard,Legacy' -split ',') | Sort-Object) -join ',')
        }
        It "$commandName should take PasswordType from the pipeline by value" -TestCases $commandDetails {
            @($_.Parameters['PasswordType'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] -and $_.ValueFromPipeline }).Count | Should -BeGreaterThan 0
        }
    }
    BeforeDiscovery {
        $setCases = @(
            @{ CommandName = $commandName; SetName = 'object'; Mandatory = @('TssSession', 'PasswordType'); Optional = @(); Absent = @('Id', 'Name', 'Active', 'CustomPort', 'LineEnding', 'UseUsernameAndPassword', 'IgnoreSSL', 'UseSSL', 'ValidForTakeover', 'RequestTerminal', 'RunnerType', 'ExitCommand', 'WindowsCustomPorts', 'OdbcConnectionString', 'MainframeConnectionString', 'RpcScriptId', 'RpcScriptArgs', 'HeartbeatScriptId', 'HeartbeatScriptArgs') }
            @{ CommandName = $commandName; SetName = 'field'; Mandatory = @('TssSession', 'Id'); Optional = @('Name', 'Active', 'CustomPort', 'LineEnding', 'UseUsernameAndPassword', 'IgnoreSSL', 'UseSSL', 'ValidForTakeover', 'RequestTerminal', 'RunnerType', 'ExitCommand', 'WindowsCustomPorts', 'OdbcConnectionString', 'MainframeConnectionString', 'RpcScriptId', 'RpcScriptArgs', 'HeartbeatScriptId', 'HeartbeatScriptArgs'); Absent = @('PasswordType') }
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
