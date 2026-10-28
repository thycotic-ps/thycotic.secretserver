BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Active', 'DateRange', 'EndDate', 'EndTime', 'ExcludedApplications', 'FolderId', 'GroupIds', 'HasError', 'IncludeNonSecretServerSessions', 'IncludeOnlyLaunchedSuccessfully', 'IncludeRestricted', 'IncludeSubFolders', 'LauncherTypeId', 'SearchText', 'SearchTypes', 'SecretIds', 'SiteId', 'StartDate', 'StartTime', 'UserIds'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession'); Optional = @('Active', 'DateRange', 'EndDate', 'EndTime', 'ExcludedApplications', 'FolderId', 'GroupIds', 'HasError', 'IncludeNonSecretServerSessions', 'IncludeOnlyLaunchedSuccessfully', 'IncludeRestricted', 'IncludeSubFolders', 'LauncherTypeId', 'SearchText', 'SearchTypes', 'SecretIds', 'SiteId', 'StartDate', 'StartTime', 'UserIds'); Absent = @() }
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
        It "$commandName should set OutputType to Thycotic.PowerShell.RecordedSessions.RecordedSessionItem[]" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.RecordedSessions.RecordedSessionItem[]'
        }
        It "$commandName should take TssSession as Thycotic.PowerShell.Authentication.Session" -TestCases $commandDetails {
            $_.Parameters['TssSession'].ParameterType.FullName | Should -Be 'Thycotic.PowerShell.Authentication.Session'
        }
        It "$commandName should take Active as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['Active'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take DateRange as System.Int32" -TestCases $commandDetails {
            $_.Parameters['DateRange'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take EndDate as System.DateTime" -TestCases $commandDetails {
            $_.Parameters['EndDate'].ParameterType.FullName | Should -Be 'System.DateTime'
        }
        It "$commandName should take EndTime as System.String" -TestCases $commandDetails {
            $_.Parameters['EndTime'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take ExcludedApplications as System.String[]" -TestCases $commandDetails {
            $_.Parameters['ExcludedApplications'].ParameterType.FullName | Should -Be 'System.String[]'
        }
        It "$commandName should take FolderId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['FolderId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take GroupIds as System.Int32[]" -TestCases $commandDetails {
            $_.Parameters['GroupIds'].ParameterType.FullName | Should -Be 'System.Int32[]'
        }
        It "$commandName should take HasError as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['HasError'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take IncludeNonSecretServerSessions as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['IncludeNonSecretServerSessions'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take IncludeOnlyLaunchedSuccessfully as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['IncludeOnlyLaunchedSuccessfully'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take IncludeRestricted as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['IncludeRestricted'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take IncludeSubFolders as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['IncludeSubFolders'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take LauncherTypeId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['LauncherTypeId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take SearchText as System.String" -TestCases $commandDetails {
            $_.Parameters['SearchText'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take SearchTypes as System.String[]" -TestCases $commandDetails {
            $_.Parameters['SearchTypes'].ParameterType.FullName | Should -Be 'System.String[]'
        }
        It "$commandName should take SecretIds as System.Int32[]" -TestCases $commandDetails {
            $_.Parameters['SecretIds'].ParameterType.FullName | Should -Be 'System.Int32[]'
        }
        It "$commandName should take SiteId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['SiteId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take StartDate as System.DateTime" -TestCases $commandDetails {
            $_.Parameters['StartDate'].ParameterType.FullName | Should -Be 'System.DateTime'
        }
        It "$commandName should take StartTime as System.String" -TestCases $commandDetails {
            $_.Parameters['StartTime'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take UserIds as System.Int32[]" -TestCases $commandDetails {
            $_.Parameters['UserIds'].ParameterType.FullName | Should -Be 'System.Int32[]'
        }
        It "$commandName should limit SearchTypes to SecretName,SecretItems,Username,Hostname,Domain,RdpKeystroke,RdpApplication,ProxyClient" -TestCases $commandDetails {
            (($_.Parameters['SearchTypes'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('SecretName,SecretItems,Username,Hostname,Domain,RdpKeystroke,RdpApplication,ProxyClient' -split ',') | Sort-Object) -join ',')
        }
        It "$commandName should take TssSession from the pipeline (ValueFromPipeline)" -TestCases $commandDetails {
            @($_.Parameters['TssSession'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] -and $_.ValueFromPipeline }).Count | Should -BeGreaterThan 0
        }
        It "$commandName should bind TssSession at position 0" -TestCases $commandDetails {
            @($_.Parameters['TssSession'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] }).Position | Should -Contain 0
        }
        It "$commandName pipeline/output type Thycotic.PowerShell.RecordedSessions.RecordedSessionItem should expose LauncherSessionGuid as System.String" {
            ([type]'Thycotic.PowerShell.RecordedSessions.RecordedSessionItem').GetProperty('LauncherSessionGuid').PropertyType.FullName | Should -Be 'System.String'
        }
        It "$commandName pipeline/output type Thycotic.PowerShell.RecordedSessions.RecordedSessionItem should expose IsLauncher as System.Boolean" {
            ([type]'Thycotic.PowerShell.RecordedSessions.RecordedSessionItem').GetProperty('IsLauncher').PropertyType.FullName | Should -Be 'System.Boolean'
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
