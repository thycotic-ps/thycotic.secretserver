BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id', 'Active', 'AddCommentsToTicket', 'BmcChangeManagementCommentWorkType', 'BmcIncidentManagementCommentWorkType', 'BmcRemedyAuthentication', 'BmcRemedyUrlEndpoint', 'Description', 'DisplayMessage', 'EnableTicketOverride', 'ForceRequireTicketNumber', 'HideComment', 'IsDefault', 'Name', 'PowerShellAddCommentScriptArguments', 'PowerShellAddCommentScriptId', 'PowerShellAddTicketCommentScriptArguments', 'PowerShellAddTicketCommentScriptId', 'PowerShellRunAsAccountSecretId', 'PowerShellTicketStatusScriptArguments', 'PowerShellTicketStatusScriptId', 'ServiceNowAllowedStatuses', 'ServiceNowDomainName', 'SiteId', 'SystemCredentialSecretId', 'TicketNumberErrorMessage', 'TicketNumberValidation', 'TicketOverrideApproverGroupId', 'TicketOverrideApproverUserId', 'TicketOverrideDenyComment', 'TicketOverrideDurationMinutes', 'TicketOverrideSecretOwners', 'TicketSystemType', 'ViewTicketUrl'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession', 'Id'); Optional = @('Active', 'AddCommentsToTicket', 'BmcChangeManagementCommentWorkType', 'BmcIncidentManagementCommentWorkType', 'BmcRemedyAuthentication', 'BmcRemedyUrlEndpoint', 'Description', 'DisplayMessage', 'EnableTicketOverride', 'ForceRequireTicketNumber', 'HideComment', 'IsDefault', 'Name', 'PowerShellAddCommentScriptArguments', 'PowerShellAddCommentScriptId', 'PowerShellAddTicketCommentScriptArguments', 'PowerShellAddTicketCommentScriptId', 'PowerShellRunAsAccountSecretId', 'PowerShellTicketStatusScriptArguments', 'PowerShellTicketStatusScriptId', 'ServiceNowAllowedStatuses', 'ServiceNowDomainName', 'SiteId', 'SystemCredentialSecretId', 'TicketNumberErrorMessage', 'TicketNumberValidation', 'TicketOverrideApproverGroupId', 'TicketOverrideApproverUserId', 'TicketOverrideDenyComment', 'TicketOverrideDurationMinutes', 'TicketOverrideSecretOwners', 'TicketSystemType', 'ViewTicketUrl'); Absent = @() }
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
        It "$commandName should set OutputType to Thycotic.PowerShell.TicketSystems.TicketSystem" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.TicketSystems.TicketSystem'
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
        It "$commandName should take Id as System.Int32" -TestCases $commandDetails {
            $_.Parameters['Id'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take Active as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['Active'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take AddCommentsToTicket as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['AddCommentsToTicket'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take BmcChangeManagementCommentWorkType as System.String" -TestCases $commandDetails {
            $_.Parameters['BmcChangeManagementCommentWorkType'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take BmcIncidentManagementCommentWorkType as System.String" -TestCases $commandDetails {
            $_.Parameters['BmcIncidentManagementCommentWorkType'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take BmcRemedyAuthentication as System.String" -TestCases $commandDetails {
            $_.Parameters['BmcRemedyAuthentication'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take BmcRemedyUrlEndpoint as System.String" -TestCases $commandDetails {
            $_.Parameters['BmcRemedyUrlEndpoint'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take Description as System.String" -TestCases $commandDetails {
            $_.Parameters['Description'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take DisplayMessage as System.String" -TestCases $commandDetails {
            $_.Parameters['DisplayMessage'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take EnableTicketOverride as System.String" -TestCases $commandDetails {
            $_.Parameters['EnableTicketOverride'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take ForceRequireTicketNumber as System.String" -TestCases $commandDetails {
            $_.Parameters['ForceRequireTicketNumber'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take HideComment as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['HideComment'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take IsDefault as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['IsDefault'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take Name as System.String" -TestCases $commandDetails {
            $_.Parameters['Name'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take PowerShellAddCommentScriptArguments as System.String" -TestCases $commandDetails {
            $_.Parameters['PowerShellAddCommentScriptArguments'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take PowerShellAddCommentScriptId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['PowerShellAddCommentScriptId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take PowerShellAddTicketCommentScriptArguments as System.String" -TestCases $commandDetails {
            $_.Parameters['PowerShellAddTicketCommentScriptArguments'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take PowerShellAddTicketCommentScriptId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['PowerShellAddTicketCommentScriptId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take PowerShellRunAsAccountSecretId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['PowerShellRunAsAccountSecretId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take PowerShellTicketStatusScriptArguments as System.String" -TestCases $commandDetails {
            $_.Parameters['PowerShellTicketStatusScriptArguments'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take PowerShellTicketStatusScriptId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['PowerShellTicketStatusScriptId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take ServiceNowAllowedStatuses as System.String" -TestCases $commandDetails {
            $_.Parameters['ServiceNowAllowedStatuses'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take ServiceNowDomainName as System.String" -TestCases $commandDetails {
            $_.Parameters['ServiceNowDomainName'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take SiteId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['SiteId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take SystemCredentialSecretId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['SystemCredentialSecretId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take TicketNumberErrorMessage as System.String" -TestCases $commandDetails {
            $_.Parameters['TicketNumberErrorMessage'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take TicketNumberValidation as System.String" -TestCases $commandDetails {
            $_.Parameters['TicketNumberValidation'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take TicketOverrideApproverGroupId as System.Int32[]" -TestCases $commandDetails {
            $_.Parameters['TicketOverrideApproverGroupId'].ParameterType.FullName | Should -Be 'System.Int32[]'
        }
        It "$commandName should take TicketOverrideApproverUserId as System.Int32[]" -TestCases $commandDetails {
            $_.Parameters['TicketOverrideApproverUserId'].ParameterType.FullName | Should -Be 'System.Int32[]'
        }
        It "$commandName should take TicketOverrideDenyComment as System.String" -TestCases $commandDetails {
            $_.Parameters['TicketOverrideDenyComment'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take TicketOverrideDurationMinutes as System.Int32" -TestCases $commandDetails {
            $_.Parameters['TicketOverrideDurationMinutes'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take TicketOverrideSecretOwners as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['TicketOverrideSecretOwners'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take TicketSystemType as System.String" -TestCases $commandDetails {
            $_.Parameters['TicketSystemType'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take ViewTicketUrl as System.String" -TestCases $commandDetails {
            $_.Parameters['ViewTicketUrl'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should limit TicketSystemType to TicketNumberValidation,BmcRemedyIncidentManagement,BmcRemedyChangeManagement,PowerShell,ServiceNowChangeManagement,ServiceNowIncidentManagement" -TestCases $commandDetails {
            (($_.Parameters['TicketSystemType'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('TicketNumberValidation,BmcRemedyIncidentManagement,BmcRemedyChangeManagement,PowerShell,ServiceNowChangeManagement,ServiceNowIncidentManagement' -split ',') | Sort-Object) -join ',')
        }
        It "$commandName should limit ForceRequireTicketNumber to ReasonOnlyRequired,BothRequired,TicketNumberOrReasonRequired,TicketNumberOnlyRequired" -TestCases $commandDetails {
            (($_.Parameters['ForceRequireTicketNumber'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('ReasonOnlyRequired,BothRequired,TicketNumberOrReasonRequired,TicketNumberOnlyRequired' -split ',') | Sort-Object) -join ',')
        }
        It "$commandName should limit EnableTicketOverride to Off,On,OnlyWhenValidationFails" -TestCases $commandDetails {
            (($_.Parameters['EnableTicketOverride'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('Off,On,OnlyWhenValidationFails' -split ',') | Sort-Object) -join ',')
        }
        It "$commandName should accept TicketSystemId as an alias of Id" -TestCases $commandDetails {
            $_.Parameters['Id'].Aliases | Should -Contain 'TicketSystemId'
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
        It "$commandName should allow an empty TicketOverrideApproverUserId collection" -TestCases $commandDetails {
            @($_.Parameters['TicketOverrideApproverUserId'].Attributes | Where-Object { $_ -is [System.Management.Automation.AllowEmptyCollectionAttribute] }).Count | Should -Be 1
        }
        It "$commandName should allow an empty TicketOverrideApproverGroupId collection" -TestCases $commandDetails {
            @($_.Parameters['TicketOverrideApproverGroupId'].Attributes | Where-Object { $_ -is [System.Management.Automation.AllowEmptyCollectionAttribute] }).Count | Should -Be 1
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
