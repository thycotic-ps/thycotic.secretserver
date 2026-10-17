BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id', 'CommandTypeCode', 'Username', 'Password', 'Key', 'Passphrase'
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
        It "$commandName should set OutputType to Thycotic.PowerShell.Rpc.PasswordTypeAuth[]" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.Rpc.PasswordTypeAuth[]'
        }
        It "$commandName should support ShouldProcess" -TestCases $commandDetails {
            $_.Parameters.ContainsKey('WhatIf') | Should -Be $true
        }
        It "$commandName should set ConfirmImpact to Medium" -TestCases $commandDetails {
            ($_.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }).ConfirmImpact | Should -Be 'Medium'
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
        It "$commandName should take CommandTypeCode as System.Int32" -TestCases $commandDetails {
            $_.Parameters['CommandTypeCode'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take Username as System.String" -TestCases $commandDetails {
            $_.Parameters['Username'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take Password as System.Security.SecureString" -TestCases $commandDetails {
            $_.Parameters['Password'].ParameterType.FullName | Should -Be 'System.Security.SecureString'
        }
        It "$commandName should take Key as System.String" -TestCases $commandDetails {
            $_.Parameters['Key'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take Passphrase as System.Security.SecureString" -TestCases $commandDetails {
            $_.Parameters['Passphrase'].ParameterType.FullName | Should -Be 'System.Security.SecureString'
        }
        It "$commandName should limit CommandTypeCode to 1..5" -TestCases $commandDetails {
            $vr = @($_.Parameters['CommandTypeCode'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateRangeAttribute] })[0]
            "$($vr.MinRange)..$($vr.MaxRange)" | Should -BeExactly '1..5'
        }
    }
    BeforeDiscovery {
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession', 'Id', 'CommandTypeCode'); Optional = @('Username', 'Password', 'Key', 'Passphrase'); Absent = @() }
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
