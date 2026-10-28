BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Name', 'BasePasswordTypeId', 'TypeName', 'PasswordTypeField'
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
        It "$commandName should accept PasswordTypeId as an alias of BasePasswordTypeId" -TestCases $commandDetails {
            $_.Parameters['BasePasswordTypeId'].Aliases | Should -Contain 'PasswordTypeId'
        }
        It "$commandName should take BasePasswordTypeId from the pipeline by property name" -TestCases $commandDetails {
            @($_.Parameters['BasePasswordTypeId'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] -and $_.ValueFromPipelineByPropertyName }).Count | Should -BeGreaterThan 0
        }
        It "$commandName should take Name as System.String" -TestCases $commandDetails {
            $_.Parameters['Name'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take BasePasswordTypeId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['BasePasswordTypeId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take TypeName as System.String" -TestCases $commandDetails {
            $_.Parameters['TypeName'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take PasswordTypeField as System.Object[]" -TestCases $commandDetails {
            $_.Parameters['PasswordTypeField'].ParameterType.FullName | Should -Be 'System.Object[]'
        }
    }
    BeforeDiscovery {
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession', 'Name'); Optional = @('BasePasswordTypeId', 'TypeName', 'PasswordTypeField'); Absent = @() }
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
