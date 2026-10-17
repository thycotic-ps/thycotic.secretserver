BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id', 'Active', 'AuthType', 'ClientId', 'ClientSecret', 'DistinguishedName', 'DomainName', 'FriendlyName', 'PreventNoUsersLockout', 'MfaProvider', 'SiteId', 'SecretId', 'TenantId', 'UserAuthType', 'UseSecureLdap', 'V2'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = 'Default'; Mandatory = @('TssSession', 'Id'); Optional = @('Active', 'AuthType', 'ClientId', 'ClientSecret', 'DistinguishedName', 'DomainName', 'FriendlyName', 'PreventNoUsersLockout', 'MfaProvider', 'SiteId', 'SecretId', 'TenantId', 'UserAuthType', 'UseSecureLdap'); Absent = @('V2') }
            @{ CommandName = $commandName; SetName = 'V2'; Mandatory = @('TssSession', 'Id', 'V2'); Optional = @('Active', 'AuthType', 'DistinguishedName', 'DomainName', 'FriendlyName', 'PreventNoUsersLockout', 'MfaProvider', 'SiteId', 'SecretId', 'UserAuthType', 'UseSecureLdap'); Absent = @('ClientId', 'ClientSecret', 'TenantId') }
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
        It "$commandName should set OutputType to Thycotic.PowerShell.DirectoryServices.DirectoryDomain" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.DirectoryServices.DirectoryDomain'
        }
        It "$commandName should support ShouldProcess" -TestCases $commandDetails {
            $_.Parameters.ContainsKey('WhatIf') | Should -Be $true
        }
        It "$commandName should default to the Default parameter set" -TestCases $commandDetails {
            $_.DefaultParameterSet | Should -Be 'Default'
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
        It "$commandName should take AuthType as Thycotic.PowerShell.Enums.LdapAuthType" -TestCases $commandDetails {
            $_.Parameters['AuthType'].ParameterType.FullName | Should -Be 'Thycotic.PowerShell.Enums.LdapAuthType'
        }
        It "$commandName should take ClientId as System.String" -TestCases $commandDetails {
            $_.Parameters['ClientId'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take ClientSecret as System.Security.SecureString" -TestCases $commandDetails {
            $_.Parameters['ClientSecret'].ParameterType.FullName | Should -Be 'System.Security.SecureString'
        }
        It "$commandName should take DistinguishedName as System.String" -TestCases $commandDetails {
            $_.Parameters['DistinguishedName'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take DomainName as System.String" -TestCases $commandDetails {
            $_.Parameters['DomainName'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take FriendlyName as System.String" -TestCases $commandDetails {
            $_.Parameters['FriendlyName'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take PreventNoUsersLockout as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['PreventNoUsersLockout'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take MfaProvider as System.String" -TestCases $commandDetails {
            $_.Parameters['MfaProvider'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take SiteId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['SiteId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take SecretId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['SecretId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take TenantId as System.String" -TestCases $commandDetails {
            $_.Parameters['TenantId'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take UserAuthType as Thycotic.PowerShell.Enums.UserAuthType" -TestCases $commandDetails {
            $_.Parameters['UserAuthType'].ParameterType.FullName | Should -Be 'Thycotic.PowerShell.Enums.UserAuthType'
        }
        It "$commandName should take UseSecureLdap as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['UseSecureLdap'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take V2 as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['V2'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should limit MfaProvider to None,Radius,TOTPAuthenticator,Duo,Fido2,Email" -TestCases $commandDetails {
            (($_.Parameters['MfaProvider'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('None,Radius,TOTPAuthenticator,Duo,Fido2,Email' -split ',') | Sort-Object) -join ',')
        }
        It "$commandName should accept DomainId as an alias of Id" -TestCases $commandDetails {
            $_.Parameters['Id'].Aliases | Should -Contain 'DomainId'
        }
        It "$commandName should accept IsPreventNoUsersLockoutEnabled as an alias of PreventNoUsersLockout" -TestCases $commandDetails {
            $_.Parameters['PreventNoUsersLockout'].Aliases | Should -Contain 'IsPreventNoUsersLockoutEnabled'
        }
        It "$commandName should accept MultifactorAuthenticationProvider as an alias of MfaProvider" -TestCases $commandDetails {
            $_.Parameters['MfaProvider'].Aliases | Should -Contain 'MultifactorAuthenticationProvider'
        }
        It "$commandName should accept SynchronizationSecretId as an alias of SecretId" -TestCases $commandDetails {
            $_.Parameters['SecretId'].Aliases | Should -Contain 'SynchronizationSecretId'
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
        It "$commandName pipeline/output type Thycotic.PowerShell.ActiveDirectory.DomainSummary should expose DomainId as System.Int32" {
            ([type]'Thycotic.PowerShell.ActiveDirectory.DomainSummary').GetProperty('DomainId').PropertyType.FullName | Should -Be 'System.Int32'
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
