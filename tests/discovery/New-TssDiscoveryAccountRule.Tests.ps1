BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'AccountAlerts', 'AccountNameContains', 'ActionCreateSecrets', 'ComputerNameContains', 'CurrentPassphrase', 'CurrentPassword', 'CurrentPrivateKey', 'DiscoverySourceId', 'FilterFields', 'FolderId', 'ImportOnlyPolledLastScan', 'IncludeChildOUs', 'IsActive', 'MatchingCondition', 'NewPassword', 'OperatingSystemContains', 'OrganizationUnitId', 'PasswordChangingPrivilegedAccountSecretId', 'PasswordChangingType', 'PasswordOption', 'RuleDescription', 'RuleName', 'ScanTemplateId', 'SecretNamePattern', 'SecretPermissions', 'SecretTemplateId', 'SiteId', 'SubscribedSpecificGroupId', 'SubscriberType', 'TakeOverAccountType', 'TakeOverPasswordTypeId', 'TakeoverSecretId', 'TakeOverThreshold'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession', 'DiscoverySourceId', 'RuleDescription', 'RuleName', 'ScanTemplateId'); Optional = @('AccountAlerts', 'AccountNameContains', 'ActionCreateSecrets', 'ComputerNameContains', 'CurrentPassphrase', 'CurrentPassword', 'CurrentPrivateKey', 'FilterFields', 'FolderId', 'ImportOnlyPolledLastScan', 'IncludeChildOUs', 'IsActive', 'MatchingCondition', 'NewPassword', 'OperatingSystemContains', 'OrganizationUnitId', 'PasswordChangingPrivilegedAccountSecretId', 'PasswordChangingType', 'PasswordOption', 'SecretNamePattern', 'SecretPermissions', 'SecretTemplateId', 'SiteId', 'SubscribedSpecificGroupId', 'SubscriberType', 'TakeOverAccountType', 'TakeOverPasswordTypeId', 'TakeoverSecretId', 'TakeOverThreshold'); Absent = @() }
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
        It "$commandName should set OutputType to Thycotic.PowerShell.Discovery.AccountRule" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.Discovery.AccountRule'
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
        It "$commandName should take RuleName as System.String" -TestCases $commandDetails {
            $_.Parameters['RuleName'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take RuleDescription as System.String" -TestCases $commandDetails {
            $_.Parameters['RuleDescription'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take DiscoverySourceId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['DiscoverySourceId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take ScanTemplateId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['ScanTemplateId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take CurrentPassword as System.Security.SecureString" -TestCases $commandDetails {
            $_.Parameters['CurrentPassword'].ParameterType.FullName | Should -Be 'System.Security.SecureString'
        }
        It "$commandName should take CurrentPassphrase as System.Security.SecureString" -TestCases $commandDetails {
            $_.Parameters['CurrentPassphrase'].ParameterType.FullName | Should -Be 'System.Security.SecureString'
        }
        It "$commandName should take CurrentPrivateKey as System.Security.SecureString" -TestCases $commandDetails {
            $_.Parameters['CurrentPrivateKey'].ParameterType.FullName | Should -Be 'System.Security.SecureString'
        }
        It "$commandName should take NewPassword as System.Security.SecureString" -TestCases $commandDetails {
            $_.Parameters['NewPassword'].ParameterType.FullName | Should -Be 'System.Security.SecureString'
        }
        It "$commandName should take IsActive as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['IsActive'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take FilterFields as System.Object[]" -TestCases $commandDetails {
            $_.Parameters['FilterFields'].ParameterType.FullName | Should -Be 'System.Object[]'
        }
        It "$commandName should take TakeoverSecretId as System.Int32[]" -TestCases $commandDetails {
            $_.Parameters['TakeoverSecretId'].ParameterType.FullName | Should -Be 'System.Int32[]'
        }
        It "$commandName should take SubscribedSpecificGroupId as System.Int32[]" -TestCases $commandDetails {
            $_.Parameters['SubscribedSpecificGroupId'].ParameterType.FullName | Should -Be 'System.Int32[]'
        }
        It "$commandName should take PasswordChangingPrivilegedAccountSecretId as System.Int32[]" -TestCases $commandDetails {
            $_.Parameters['PasswordChangingPrivilegedAccountSecretId'].ParameterType.FullName | Should -Be 'System.Int32[]'
        }
        It "$commandName should limit MatchingCondition to And,Or" -TestCases $commandDetails {
            (($_.Parameters['MatchingCondition'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('And,Or' -split ',') | Sort-Object) -join ',')
        }
        It "$commandName should limit PasswordOption to Current,ChangeTo,Random,PrivateKey,PublicKey" -TestCases $commandDetails {
            (($_.Parameters['PasswordOption'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('Current,ChangeTo,Random,PrivateKey,PublicKey' -split ',') | Sort-Object) -join ',')
        }
        It "$commandName should limit PasswordChangingType to PrivilegedAccount,SecretCredentials" -TestCases $commandDetails {
            (($_.Parameters['PasswordChangingType'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('PrivilegedAccount,SecretCredentials' -split ',') | Sort-Object) -join ',')
        }
        It "$commandName should limit SecretPermissions to InheritPermission,CopyPermission" -TestCases $commandDetails {
            (($_.Parameters['SecretPermissions'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('InheritPermission,CopyPermission' -split ',') | Sort-Object) -join ',')
        }
        It "$commandName should limit SubscriberType to Admins,SpecificUsers" -TestCases $commandDetails {
            (($_.Parameters['SubscriberType'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('Admins,SpecificUsers' -split ',') | Sort-Object) -join ',')
        }
        It "$commandName should limit TakeOverAccountType to Single,Multiple" -TestCases $commandDetails {
            (($_.Parameters['TakeOverAccountType'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('Single,Multiple' -split ',') | Sort-Object) -join ',')
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
