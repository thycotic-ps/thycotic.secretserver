BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'DomainType', 'DomainName', 'FriendlyName', 'Active', 'SiteId', 'SecretId', 'UseSecureLdap', 'MfaProvider', 'DistinguishedName', 'AuthType', 'UserAuthType', 'TenantId', 'ClientId', 'ClientSecret'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession', 'DomainType', 'DomainName'); Optional = @('FriendlyName', 'Active', 'SiteId', 'SecretId', 'UseSecureLdap', 'MfaProvider', 'DistinguishedName', 'AuthType', 'UserAuthType', 'TenantId', 'ClientId', 'ClientSecret'); Absent = @() }
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
        It "$commandName should set OutputType to Thycotic.PowerShell.ActiveDirectory.Domain" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.ActiveDirectory.Domain'
        }
        It "$commandName should support ShouldProcess" -TestCases $commandDetails {
            $_.Parameters.ContainsKey('WhatIf') | Should -Be $true
        }
        It "$commandName should take TssSession as Thycotic.PowerShell.Authentication.Session" -TestCases $commandDetails {
            $_.Parameters['TssSession'].ParameterType.FullName | Should -Be 'Thycotic.PowerShell.Authentication.Session'
        }
        It "$commandName should take DomainType as System.String" -TestCases $commandDetails {
            $_.Parameters['DomainType'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take DomainName as System.String" -TestCases $commandDetails {
            $_.Parameters['DomainName'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take FriendlyName as System.String" -TestCases $commandDetails {
            $_.Parameters['FriendlyName'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take Active as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['Active'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take SiteId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['SiteId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take SecretId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['SecretId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take UseSecureLdap as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['UseSecureLdap'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take MfaProvider as System.String" -TestCases $commandDetails {
            $_.Parameters['MfaProvider'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take DistinguishedName as System.String" -TestCases $commandDetails {
            $_.Parameters['DistinguishedName'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take AuthType as Thycotic.PowerShell.Enums.LdapAuthType" -TestCases $commandDetails {
            $_.Parameters['AuthType'].ParameterType.FullName | Should -Be 'Thycotic.PowerShell.Enums.LdapAuthType'
        }
        It "$commandName should take UserAuthType as Thycotic.PowerShell.Enums.UserAuthType" -TestCases $commandDetails {
            $_.Parameters['UserAuthType'].ParameterType.FullName | Should -Be 'Thycotic.PowerShell.Enums.UserAuthType'
        }
        It "$commandName should take TenantId as System.Guid" -TestCases $commandDetails {
            $_.Parameters['TenantId'].ParameterType.FullName | Should -Be 'System.Guid'
        }
        It "$commandName should take ClientId as System.Guid" -TestCases $commandDetails {
            $_.Parameters['ClientId'].ParameterType.FullName | Should -Be 'System.Guid'
        }
        It "$commandName should take ClientSecret as System.Security.SecureString" -TestCases $commandDetails {
            $_.Parameters['ClientSecret'].ParameterType.FullName | Should -Be 'System.Security.SecureString'
        }
        It "$commandName should limit DomainType to ActiveDirectory,OpenLdap,AzureActiveDirectory" -TestCases $commandDetails {
            (($_.Parameters['DomainType'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('ActiveDirectory,OpenLdap,AzureActiveDirectory' -split ',') | Sort-Object) -join ',')
        }
        It "$commandName should limit MfaProvider to None,Radius,TOTPAuthenticator,Duo,Fido2,Email" -TestCases $commandDetails {
            (($_.Parameters['MfaProvider'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('None,Radius,TOTPAuthenticator,Duo,Fido2,Email' -split ',') | Sort-Object) -join ',')
        }
        It "$commandName should accept SyncSecretId as an alias of SecretId" -TestCases $commandDetails {
            $_.Parameters['SecretId'].Aliases | Should -Contain 'SyncSecretId'
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
