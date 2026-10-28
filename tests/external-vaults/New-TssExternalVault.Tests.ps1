BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Active', 'CredentialSecretId', 'DisplayName', 'ExternalVaultType', 'HashiCorpEdition', 'HashiCorpKvVersion', 'HashiCorpMountPoint', 'HashiCorpNamespace', 'HashiCorpSkipCertificateValidation', 'Name', 'SecretRegex', 'SiteId'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession', 'CredentialSecretId', 'ExternalVaultType', 'Name'); Optional = @('Active', 'DisplayName', 'HashiCorpEdition', 'HashiCorpKvVersion', 'HashiCorpMountPoint', 'HashiCorpNamespace', 'HashiCorpSkipCertificateValidation', 'SecretRegex', 'SiteId'); Absent = @() }
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
        It "$commandName should set OutputType to Thycotic.PowerShell.ExternalVaults.ExternalVault" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.ExternalVaults.ExternalVault'
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
        It "$commandName should take Active as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['Active'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take CredentialSecretId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['CredentialSecretId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take DisplayName as System.String" -TestCases $commandDetails {
            $_.Parameters['DisplayName'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take ExternalVaultType as System.String" -TestCases $commandDetails {
            $_.Parameters['ExternalVaultType'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take HashiCorpEdition as System.String" -TestCases $commandDetails {
            $_.Parameters['HashiCorpEdition'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take HashiCorpKvVersion as System.Int32" -TestCases $commandDetails {
            $_.Parameters['HashiCorpKvVersion'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take HashiCorpMountPoint as System.String" -TestCases $commandDetails {
            $_.Parameters['HashiCorpMountPoint'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take HashiCorpNamespace as System.String" -TestCases $commandDetails {
            $_.Parameters['HashiCorpNamespace'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take HashiCorpSkipCertificateValidation as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['HashiCorpSkipCertificateValidation'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take Name as System.String" -TestCases $commandDetails {
            $_.Parameters['Name'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take SecretRegex as System.String" -TestCases $commandDetails {
            $_.Parameters['SecretRegex'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take SiteId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['SiteId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should limit HashiCorpEdition to Community,Enterprise,HCP" -TestCases $commandDetails {
            (($_.Parameters['HashiCorpEdition'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('Community,Enterprise,HCP' -split ',') | Sort-Object) -join ',')
        }
        It "$commandName should limit ExternalVaultType to AzureKeyVault,AWSSecretsManager,GoogleSecretManager,HashiCorpVault" -TestCases $commandDetails {
            (($_.Parameters['ExternalVaultType'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('AzureKeyVault,AWSSecretsManager,GoogleSecretManager,HashiCorpVault' -split ',') | Sort-Object) -join ',')
        }
        It "$commandName should default HashiCorpEdition to Community" -TestCases $commandDetails {
            ($_.ScriptBlock.Ast.Body.ParamBlock.Parameters | Where-Object { $_.Name.VariablePath.UserPath -eq 'HashiCorpEdition' }).DefaultValue.SafeGetValue() | Should -BeExactly 'Community'
        }
        It "$commandName should default HashiCorpKvVersion to 2" -TestCases $commandDetails {
            ($_.ScriptBlock.Ast.Body.ParamBlock.Parameters | Where-Object { $_.Name.VariablePath.UserPath -eq 'HashiCorpKvVersion' }).DefaultValue.SafeGetValue() | Should -BeExactly '2'
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
