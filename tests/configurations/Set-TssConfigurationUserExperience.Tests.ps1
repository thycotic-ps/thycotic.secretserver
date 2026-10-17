BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'ApplicationLanguage', 'ApprovalAllowApproverChangeRequestTime', 'ApprovalAllowCustomDuration', 'ApprovalAllowedMinuteDurations', 'ApprovalMaxRequestMinutes', 'CheckoutNotificationThreshold', 'DefaultDateFormat', 'DefaultNewUserRoleId', 'DefaultTimeFormat', 'DisableLegacyBookmarkPages', 'EnableIconGathering', 'EnableRequestForceCheckout', 'EnableSecretCheckOutExtension', 'ForceInactivityTimeout', 'ForceInactivityTimeoutMinutes', 'IncludeSessionInfoOnAllSecretAudits', 'MaxCheckOutExtensionInMinutes', 'PasswordMaskTimeout', 'RequireFolderForSecret', 'SearchDelayMs', 'SecretCommentIntervalMinutes', 'SecretPasswordDisplayedIntervalMinutes', 'SecretPasswordHistoryRestrictionAll', 'SecretPasswordHistoryRestrictionCount', 'SecretViewIntervalMinutes', 'SeparateCheckoutAndCommentAction', 'SeparateSecretAuditComment', 'ServerTimeZoneId', 'ShowSecretIcons', 'UiInactivitySleepMinutes'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession'); Optional = @('ApplicationLanguage', 'ApprovalAllowApproverChangeRequestTime', 'ApprovalAllowCustomDuration', 'ApprovalAllowedMinuteDurations', 'ApprovalMaxRequestMinutes', 'CheckoutNotificationThreshold', 'DefaultDateFormat', 'DefaultNewUserRoleId', 'DefaultTimeFormat', 'DisableLegacyBookmarkPages', 'EnableIconGathering', 'EnableRequestForceCheckout', 'EnableSecretCheckOutExtension', 'ForceInactivityTimeout', 'ForceInactivityTimeoutMinutes', 'IncludeSessionInfoOnAllSecretAudits', 'MaxCheckOutExtensionInMinutes', 'PasswordMaskTimeout', 'RequireFolderForSecret', 'SearchDelayMs', 'SecretCommentIntervalMinutes', 'SecretPasswordDisplayedIntervalMinutes', 'SecretPasswordHistoryRestrictionAll', 'SecretPasswordHistoryRestrictionCount', 'SecretViewIntervalMinutes', 'SeparateCheckoutAndCommentAction', 'SeparateSecretAuditComment', 'ServerTimeZoneId', 'ShowSecretIcons', 'UiInactivitySleepMinutes'); Absent = @() }
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
        It "$commandName should set OutputType to Thycotic.PowerShell.Configuration.ConfigurationUserExperience" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.Configuration.ConfigurationUserExperience'
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
        It "$commandName should take ApplicationLanguage as System.Int32" -TestCases $commandDetails {
            $_.Parameters['ApplicationLanguage'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take ApprovalAllowApproverChangeRequestTime as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['ApprovalAllowApproverChangeRequestTime'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take ApprovalAllowCustomDuration as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['ApprovalAllowCustomDuration'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take ApprovalAllowedMinuteDurations as System.Int32[]" -TestCases $commandDetails {
            $_.Parameters['ApprovalAllowedMinuteDurations'].ParameterType.FullName | Should -Be 'System.Int32[]'
        }
        It "$commandName should take ApprovalMaxRequestMinutes as System.Int32" -TestCases $commandDetails {
            $_.Parameters['ApprovalMaxRequestMinutes'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take CheckoutNotificationThreshold as System.Int32" -TestCases $commandDetails {
            $_.Parameters['CheckoutNotificationThreshold'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take DefaultDateFormat as System.Int32" -TestCases $commandDetails {
            $_.Parameters['DefaultDateFormat'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take DefaultNewUserRoleId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['DefaultNewUserRoleId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take DefaultTimeFormat as System.Int32" -TestCases $commandDetails {
            $_.Parameters['DefaultTimeFormat'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take DisableLegacyBookmarkPages as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['DisableLegacyBookmarkPages'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take EnableIconGathering as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['EnableIconGathering'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take EnableRequestForceCheckout as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['EnableRequestForceCheckout'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take EnableSecretCheckOutExtension as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['EnableSecretCheckOutExtension'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take ForceInactivityTimeout as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['ForceInactivityTimeout'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take ForceInactivityTimeoutMinutes as System.Int32" -TestCases $commandDetails {
            $_.Parameters['ForceInactivityTimeoutMinutes'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take IncludeSessionInfoOnAllSecretAudits as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['IncludeSessionInfoOnAllSecretAudits'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take MaxCheckOutExtensionInMinutes as System.Int32" -TestCases $commandDetails {
            $_.Parameters['MaxCheckOutExtensionInMinutes'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take PasswordMaskTimeout as System.Int32" -TestCases $commandDetails {
            $_.Parameters['PasswordMaskTimeout'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take RequireFolderForSecret as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['RequireFolderForSecret'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take SearchDelayMs as System.Int32" -TestCases $commandDetails {
            $_.Parameters['SearchDelayMs'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take SecretCommentIntervalMinutes as System.Int32" -TestCases $commandDetails {
            $_.Parameters['SecretCommentIntervalMinutes'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take SecretPasswordDisplayedIntervalMinutes as System.Int32" -TestCases $commandDetails {
            $_.Parameters['SecretPasswordDisplayedIntervalMinutes'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take SecretPasswordHistoryRestrictionAll as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['SecretPasswordHistoryRestrictionAll'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take SecretPasswordHistoryRestrictionCount as System.Int32" -TestCases $commandDetails {
            $_.Parameters['SecretPasswordHistoryRestrictionCount'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take SecretViewIntervalMinutes as System.Int32" -TestCases $commandDetails {
            $_.Parameters['SecretViewIntervalMinutes'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take SeparateCheckoutAndCommentAction as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['SeparateCheckoutAndCommentAction'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take SeparateSecretAuditComment as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['SeparateSecretAuditComment'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take ServerTimeZoneId as System.String" -TestCases $commandDetails {
            $_.Parameters['ServerTimeZoneId'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take ShowSecretIcons as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['ShowSecretIcons'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take UiInactivitySleepMinutes as System.Int32" -TestCases $commandDetails {
            $_.Parameters['UiInactivitySleepMinutes'].ParameterType.FullName | Should -Be 'System.Int32'
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
