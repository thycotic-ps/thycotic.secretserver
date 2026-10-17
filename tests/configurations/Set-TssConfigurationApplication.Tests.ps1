BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'AllowSendTelemetry', 'AllowSoftwareUpdateChecks', 'ApiRefreshTokensEnabled', 'ApiSessionTimeoutDays', 'ApiSessionTimeoutHours', 'ApiSessionTimeoutMinutes', 'ApiSessionTimeoutUnlimited', 'ConfigurationEarlyAdopterEnabled', 'CustomUrl', 'DisplayDowntimeMessageToAdminsOnly', 'EnableCredSsp', 'EnableSyslogCefLogging', 'EnableWebServices', 'MaximumTokenRefreshesAllowed', 'MaxSecretLogLength', 'MobileMaxOfflineDays', 'MobileMaxOfflineHours', 'ObfuscatePersonallyIdentifiableInformation', 'PiiObfuscationLevel', 'PreventApplicationFromSleeping', 'PreventDirectApiAuthentication', 'SyslogCefDateTimeFormat', 'SyslogCefLogSite', 'SyslogCefPort', 'SyslogCefProtocol', 'SyslogCefServer', 'SyslogCefTimeZone', 'TmsInstallationPath', 'WinRmEndpointUrl', 'WriteSyslogToEventLog'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession'); Optional = @('AllowSendTelemetry', 'AllowSoftwareUpdateChecks', 'ApiRefreshTokensEnabled', 'ApiSessionTimeoutDays', 'ApiSessionTimeoutHours', 'ApiSessionTimeoutMinutes', 'ApiSessionTimeoutUnlimited', 'ConfigurationEarlyAdopterEnabled', 'CustomUrl', 'DisplayDowntimeMessageToAdminsOnly', 'EnableCredSsp', 'EnableSyslogCefLogging', 'EnableWebServices', 'MaximumTokenRefreshesAllowed', 'MaxSecretLogLength', 'MobileMaxOfflineDays', 'MobileMaxOfflineHours', 'ObfuscatePersonallyIdentifiableInformation', 'PiiObfuscationLevel', 'PreventApplicationFromSleeping', 'PreventDirectApiAuthentication', 'SyslogCefDateTimeFormat', 'SyslogCefLogSite', 'SyslogCefPort', 'SyslogCefProtocol', 'SyslogCefServer', 'SyslogCefTimeZone', 'TmsInstallationPath', 'WinRmEndpointUrl', 'WriteSyslogToEventLog'); Absent = @() }
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
        It "$commandName should set OutputType to Thycotic.PowerShell.Configuration.ApplicationSettings" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.Configuration.ApplicationSettings'
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
        It "$commandName should take AllowSendTelemetry as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['AllowSendTelemetry'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take AllowSoftwareUpdateChecks as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['AllowSoftwareUpdateChecks'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take ApiRefreshTokensEnabled as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['ApiRefreshTokensEnabled'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take ApiSessionTimeoutDays as System.Int32" -TestCases $commandDetails {
            $_.Parameters['ApiSessionTimeoutDays'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take ApiSessionTimeoutHours as System.Int32" -TestCases $commandDetails {
            $_.Parameters['ApiSessionTimeoutHours'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take ApiSessionTimeoutMinutes as System.Int32" -TestCases $commandDetails {
            $_.Parameters['ApiSessionTimeoutMinutes'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take ApiSessionTimeoutUnlimited as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['ApiSessionTimeoutUnlimited'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take ConfigurationEarlyAdopterEnabled as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['ConfigurationEarlyAdopterEnabled'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take CustomUrl as System.String" -TestCases $commandDetails {
            $_.Parameters['CustomUrl'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take DisplayDowntimeMessageToAdminsOnly as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['DisplayDowntimeMessageToAdminsOnly'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take EnableCredSsp as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['EnableCredSsp'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take EnableSyslogCefLogging as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['EnableSyslogCefLogging'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take EnableWebServices as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['EnableWebServices'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take MaximumTokenRefreshesAllowed as System.Int32" -TestCases $commandDetails {
            $_.Parameters['MaximumTokenRefreshesAllowed'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take MaxSecretLogLength as System.Int32" -TestCases $commandDetails {
            $_.Parameters['MaxSecretLogLength'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take MobileMaxOfflineDays as System.Int32" -TestCases $commandDetails {
            $_.Parameters['MobileMaxOfflineDays'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take MobileMaxOfflineHours as System.Int32" -TestCases $commandDetails {
            $_.Parameters['MobileMaxOfflineHours'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take ObfuscatePersonallyIdentifiableInformation as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['ObfuscatePersonallyIdentifiableInformation'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take PiiObfuscationLevel as System.String" -TestCases $commandDetails {
            $_.Parameters['PiiObfuscationLevel'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take PreventApplicationFromSleeping as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['PreventApplicationFromSleeping'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take PreventDirectApiAuthentication as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['PreventDirectApiAuthentication'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take SyslogCefDateTimeFormat as System.String" -TestCases $commandDetails {
            $_.Parameters['SyslogCefDateTimeFormat'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take SyslogCefLogSite as System.Int32" -TestCases $commandDetails {
            $_.Parameters['SyslogCefLogSite'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take SyslogCefPort as System.Int32" -TestCases $commandDetails {
            $_.Parameters['SyslogCefPort'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take SyslogCefProtocol as System.String" -TestCases $commandDetails {
            $_.Parameters['SyslogCefProtocol'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take SyslogCefServer as System.String" -TestCases $commandDetails {
            $_.Parameters['SyslogCefServer'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take SyslogCefTimeZone as System.String" -TestCases $commandDetails {
            $_.Parameters['SyslogCefTimeZone'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take TmsInstallationPath as System.String" -TestCases $commandDetails {
            $_.Parameters['TmsInstallationPath'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take WinRmEndpointUrl as System.String" -TestCases $commandDetails {
            $_.Parameters['WinRmEndpointUrl'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take WriteSyslogToEventLog as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['WriteSyslogToEventLog'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should limit SyslogCefDateTimeFormat to Syslog,ISO8601" -TestCases $commandDetails {
            (($_.Parameters['SyslogCefDateTimeFormat'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('Syslog,ISO8601' -split ',') | Sort-Object) -join ',')
        }
        It "$commandName should limit SyslogCefProtocol to UDP,TCP,SECURE_TCP" -TestCases $commandDetails {
            (($_.Parameters['SyslogCefProtocol'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('UDP,TCP,SECURE_TCP' -split ',') | Sort-Object) -join ',')
        }
        It "$commandName should limit SyslogCefTimeZone to ServerTime,UtcTime" -TestCases $commandDetails {
            (($_.Parameters['SyslogCefTimeZone'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('ServerTime,UtcTime' -split ',') | Sort-Object) -join ',')
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
