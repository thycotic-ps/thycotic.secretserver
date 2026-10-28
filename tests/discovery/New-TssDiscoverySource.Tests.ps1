BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'DiscoverySourceType', 'Name', 'SiteId', 'SecretId', 'ActiveDirectory', 'Active', 'DiscoverSpecificOUs', 'MachineNameResolutionType', 'FullyQualifiedDomainName', 'FriendlyName', 'UseSecureLdap'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = 'Default'; Mandatory = @('TssSession', 'DiscoverySourceType', 'Name', 'SiteId'); Optional = @('SecretId'); Absent = @('ActiveDirectory', 'Active', 'DiscoverSpecificOUs', 'MachineNameResolutionType', 'FullyQualifiedDomainName', 'FriendlyName', 'UseSecureLdap') }
            @{ CommandName = $commandName; SetName = 'ActiveDirectory'; Mandatory = @('TssSession', 'Name', 'SiteId', 'SecretId', 'ActiveDirectory'); Optional = @('Active', 'DiscoverSpecificOUs', 'MachineNameResolutionType', 'FullyQualifiedDomainName', 'FriendlyName', 'UseSecureLdap'); Absent = @('DiscoverySourceType') }
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
        It "$commandName should set OutputType to Thycotic.PowerShell.Discovery.Source" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.Discovery.Source'
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
        It "$commandName should take DiscoverySourceType as System.String" -TestCases $commandDetails {
            $_.Parameters['DiscoverySourceType'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take Name as System.String" -TestCases $commandDetails {
            $_.Parameters['Name'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take SiteId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['SiteId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take SecretId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['SecretId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take ActiveDirectory as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['ActiveDirectory'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take Active as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['Active'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take DiscoverSpecificOUs as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['DiscoverSpecificOUs'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take MachineNameResolutionType as System.String" -TestCases $commandDetails {
            $_.Parameters['MachineNameResolutionType'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take FullyQualifiedDomainName as System.String" -TestCases $commandDetails {
            $_.Parameters['FullyQualifiedDomainName'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take FriendlyName as System.String" -TestCases $commandDetails {
            $_.Parameters['FriendlyName'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take UseSecureLdap as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['UseSecureLdap'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should limit DiscoverySourceType to Unix,ODBC,FileLoad,ManualInput,ESX,ActiveDirectory,PowerShell,AmazonWebService,GoogleCloudProvider,EntraId" -TestCases $commandDetails {
            (($_.Parameters['DiscoverySourceType'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('Unix,ODBC,FileLoad,ManualInput,ESX,ActiveDirectory,PowerShell,AmazonWebService,GoogleCloudProvider,EntraId' -split ',') | Sort-Object) -join ',')
        }
        It "$commandName should limit MachineNameResolutionType to UseMachineNameAndFQDM,OnlyUseMachineName" -TestCases $commandDetails {
            (($_.Parameters['MachineNameResolutionType'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('UseMachineNameAndFQDM,OnlyUseMachineName' -split ',') | Sort-Object) -join ',')
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
