BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'PlatformUuid', 'Name', 'DisplayName', 'EntityType', 'ServiceUser'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession', 'PlatformUuid', 'Name', 'EntityType'); Optional = @('DisplayName', 'ServiceUser'); Absent = @() }
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
        It "$commandName should set OutputType to Thycotic.PowerShell.Platform.UsersAndGroupsResult" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.Platform.UsersAndGroupsResult'
        }
        It "$commandName should support ShouldProcess" -TestCases $commandDetails {
            $_.Parameters.ContainsKey('WhatIf') | Should -Be $true
        }
        It "$commandName should set ConfirmImpact to Medium" -TestCases $commandDetails {
            ($_.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }).ConfirmImpact | Should -Be 'Medium'
        }
        It "$commandName should take TssSession as Thycotic.PowerShell.Authentication.Session" -TestCases $commandDetails {
            $_.Parameters['TssSession'].ParameterType.FullName | Should -Be 'Thycotic.PowerShell.Authentication.Session'
        }
        It "$commandName should take PlatformUuid as System.String" -TestCases $commandDetails {
            $_.Parameters['PlatformUuid'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take Name as System.String" -TestCases $commandDetails {
            $_.Parameters['Name'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take DisplayName as System.String" -TestCases $commandDetails {
            $_.Parameters['DisplayName'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take EntityType as System.String" -TestCases $commandDetails {
            $_.Parameters['EntityType'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take ServiceUser as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['ServiceUser'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should limit EntityType to User,Group,DirectoryGroup,XpmGroup" -TestCases $commandDetails {
            (($_.Parameters['EntityType'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('User,Group,DirectoryGroup,XpmGroup' -split ',') | Sort-Object) -join ',')
        }
        It "$commandName should accept PlatformEntityUuid as an alias of PlatformUuid" -TestCases $commandDetails {
            $_.Parameters['PlatformUuid'].Aliases | Should -Contain 'PlatformEntityUuid'
        }
        It "$commandName should accept EntityName as an alias of Name" -TestCases $commandDetails {
            $_.Parameters['Name'].Aliases | Should -Contain 'EntityName'
        }
        It "$commandName should take TssSession from the pipeline (ValueFromPipeline)" -TestCases $commandDetails {
            @($_.Parameters['TssSession'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] -and $_.ValueFromPipeline }).Count | Should -BeGreaterThan 0
        }
        It "$commandName should take PlatformUuid from the pipeline (ValueFromPipelineByPropertyName)" -TestCases $commandDetails {
            @($_.Parameters['PlatformUuid'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] -and $_.ValueFromPipelineByPropertyName }).Count | Should -BeGreaterThan 0
        }
        It "$commandName should take Name from the pipeline (ValueFromPipelineByPropertyName)" -TestCases $commandDetails {
            @($_.Parameters['Name'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] -and $_.ValueFromPipelineByPropertyName }).Count | Should -BeGreaterThan 0
        }
        It "$commandName should take DisplayName from the pipeline (ValueFromPipelineByPropertyName)" -TestCases $commandDetails {
            @($_.Parameters['DisplayName'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] -and $_.ValueFromPipelineByPropertyName }).Count | Should -BeGreaterThan 0
        }
        It "$commandName should take EntityType from the pipeline (ValueFromPipelineByPropertyName)" -TestCases $commandDetails {
            @($_.Parameters['EntityType'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] -and $_.ValueFromPipelineByPropertyName }).Count | Should -BeGreaterThan 0
        }
        It "$commandName should take ServiceUser from the pipeline (ValueFromPipelineByPropertyName)" -TestCases $commandDetails {
            @($_.Parameters['ServiceUser'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] -and $_.ValueFromPipelineByPropertyName }).Count | Should -BeGreaterThan 0
        }
        It "$commandName should bind TssSession at position 0" -TestCases $commandDetails {
            @($_.Parameters['TssSession'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] }).Position | Should -Contain 0
        }
        It "$commandName pipeline/output type Thycotic.PowerShell.Platform.UserGroupSummary should expose PlatformEntityUuid as System.String" {
            ([type]'Thycotic.PowerShell.Platform.UserGroupSummary').GetProperty('PlatformEntityUuid').PropertyType.FullName | Should -Be 'System.String'
        }
        It "$commandName pipeline/output type Thycotic.PowerShell.Platform.UserGroupSummary should expose Name as System.String" {
            ([type]'Thycotic.PowerShell.Platform.UserGroupSummary').GetProperty('Name').PropertyType.FullName | Should -Be 'System.String'
        }
        It "$commandName pipeline/output type Thycotic.PowerShell.Platform.UserGroupSummary should expose DisplayName as System.String" {
            ([type]'Thycotic.PowerShell.Platform.UserGroupSummary').GetProperty('DisplayName').PropertyType.FullName | Should -Be 'System.String'
        }
        It "$commandName pipeline/output type Thycotic.PowerShell.Platform.UserGroupSummary should expose EntityType as System.String" {
            ([type]'Thycotic.PowerShell.Platform.UserGroupSummary').GetProperty('EntityType').PropertyType.FullName | Should -Be 'System.String'
        }
        It "$commandName pipeline/output type Thycotic.PowerShell.Platform.UserGroupSummary should expose ServiceUser as System.Boolean" {
            ([type]'Thycotic.PowerShell.Platform.UserGroupSummary').GetProperty('ServiceUser').PropertyType.FullName | Should -Be 'System.Boolean'
        }
        It "$commandName pipeline/output type Thycotic.PowerShell.Platform.UsersAndGroupsResult should expose Error as System.String" {
            ([type]'Thycotic.PowerShell.Platform.UsersAndGroupsResult').GetProperty('Error').PropertyType.FullName | Should -Be 'System.String'
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
