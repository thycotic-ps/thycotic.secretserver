BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id', 'AuthType', 'ConvertUserToDistinguishedName', 'LookupDistinguishedNameForConnection', 'LookupDistinguishedNameForReset', 'PasswordAttribute', 'PasswordEncodingType', 'ProtocolVersion', 'SecureSocketLayer', 'UserDistinguishedNameFormat', 'UserNameAuthenticationFormat', 'UserSearchFormat'
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
        It "$commandName should set OutputType to Thycotic.PowerShell.Rpc.LdapSettings" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.Rpc.LdapSettings'
        }
        It "$commandName should support ShouldProcess" -TestCases $commandDetails {
            $_.Parameters.ContainsKey('WhatIf') | Should -Be $true
        }
        It "$commandName should set ConfirmImpact to Medium" -TestCases $commandDetails {
            ($_.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }).ConfirmImpact | Should -Be 'Medium'
        }
        It "$commandName should accept LdapConnectionSettingsId as an alias of Id" -TestCases $commandDetails {
            $_.Parameters['Id'].Aliases | Should -Contain 'LdapConnectionSettingsId'
        }
        It "$commandName should take Id from the pipeline by property name" -TestCases $commandDetails {
            @($_.Parameters['Id'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] -and $_.ValueFromPipelineByPropertyName }).Count | Should -BeGreaterThan 0
        }
        It "$commandName should take Id as System.Int32" -TestCases $commandDetails {
            $_.Parameters['Id'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take ConvertUserToDistinguishedName as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['ConvertUserToDistinguishedName'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take LookupDistinguishedNameForConnection as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['LookupDistinguishedNameForConnection'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take LookupDistinguishedNameForReset as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['LookupDistinguishedNameForReset'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take SecureSocketLayer as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['SecureSocketLayer'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take ProtocolVersion as System.Int32" -TestCases $commandDetails {
            $_.Parameters['ProtocolVersion'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take PasswordAttribute as System.String" -TestCases $commandDetails {
            $_.Parameters['PasswordAttribute'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take UserDistinguishedNameFormat as System.String" -TestCases $commandDetails {
            $_.Parameters['UserDistinguishedNameFormat'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take UserNameAuthenticationFormat as System.String" -TestCases $commandDetails {
            $_.Parameters['UserNameAuthenticationFormat'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take UserSearchFormat as System.String" -TestCases $commandDetails {
            $_.Parameters['UserSearchFormat'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should limit AuthType to Anonymous,Basic,Negotiate,Ntlm,Digest,Sicily,Dpa,Msn,External,Kerberos" -TestCases $commandDetails {
            (($_.Parameters['AuthType'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('Anonymous,Basic,Negotiate,Ntlm,Digest,Sicily,Dpa,Msn,External,Kerberos' -split ',') | Sort-Object) -join ',')
        }
        It "$commandName should limit PasswordEncodingType to OpenLdap,ActiveDirectory" -TestCases $commandDetails {
            (($_.Parameters['PasswordEncodingType'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('OpenLdap,ActiveDirectory' -split ',') | Sort-Object) -join ',')
        }
    }
    BeforeDiscovery {
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession', 'Id'); Optional = @('AuthType', 'ConvertUserToDistinguishedName', 'LookupDistinguishedNameForConnection', 'LookupDistinguishedNameForReset', 'PasswordAttribute', 'PasswordEncodingType', 'ProtocolVersion', 'SecureSocketLayer', 'UserDistinguishedNameFormat', 'UserNameAuthenticationFormat', 'UserSearchFormat'); Absent = @() }
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
