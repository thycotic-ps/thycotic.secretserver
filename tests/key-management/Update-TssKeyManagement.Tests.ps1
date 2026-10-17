BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'AwsKmsAccessKeyId', 'AwsKmsKeyArn', 'AwsKmsSecretAccessKey', 'AzureManagedHsmKeyUrl', 'AzureManagedHsmPrincipalId', 'AzureManagedHsmPrincipalSecret', 'AzureManagedHsmTenantId', 'KeyManagementTypeId'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession', 'KeyManagementTypeId'); Optional = @('AwsKmsAccessKeyId', 'AwsKmsKeyArn', 'AwsKmsSecretAccessKey', 'AzureManagedHsmKeyUrl', 'AzureManagedHsmPrincipalId', 'AzureManagedHsmPrincipalSecret', 'AzureManagedHsmTenantId'); Absent = @() }
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
        It "$commandName should set OutputType to Thycotic.PowerShell.KeyManagement.KeyManagement" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.KeyManagement.KeyManagement'
        }
        It "$commandName should support ShouldProcess" -TestCases $commandDetails {
            $_.Parameters.ContainsKey('WhatIf') | Should -Be $true
        }
        It "$commandName should set ConfirmImpact to High" -TestCases $commandDetails {
            ($_.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }).ConfirmImpact | Should -Be 'High'
        }
        It "$commandName should take TssSession as Thycotic.PowerShell.Authentication.Session" -TestCases $commandDetails {
            $_.Parameters['TssSession'].ParameterType.FullName | Should -Be 'Thycotic.PowerShell.Authentication.Session'
        }
        It "$commandName should take AwsKmsAccessKeyId as System.String" -TestCases $commandDetails {
            $_.Parameters['AwsKmsAccessKeyId'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take AwsKmsKeyArn as System.String" -TestCases $commandDetails {
            $_.Parameters['AwsKmsKeyArn'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take AwsKmsSecretAccessKey as System.Security.SecureString" -TestCases $commandDetails {
            $_.Parameters['AwsKmsSecretAccessKey'].ParameterType.FullName | Should -Be 'System.Security.SecureString'
        }
        It "$commandName should take AzureManagedHsmKeyUrl as System.String" -TestCases $commandDetails {
            $_.Parameters['AzureManagedHsmKeyUrl'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take AzureManagedHsmPrincipalId as System.String" -TestCases $commandDetails {
            $_.Parameters['AzureManagedHsmPrincipalId'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take AzureManagedHsmPrincipalSecret as System.Security.SecureString" -TestCases $commandDetails {
            $_.Parameters['AzureManagedHsmPrincipalSecret'].ParameterType.FullName | Should -Be 'System.Security.SecureString'
        }
        It "$commandName should take AzureManagedHsmTenantId as System.String" -TestCases $commandDetails {
            $_.Parameters['AzureManagedHsmTenantId'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take KeyManagementTypeId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['KeyManagementTypeId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should limit KeyManagementTypeId to 0,1,2" -TestCases $commandDetails {
            (($_.Parameters['KeyManagementTypeId'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('0,1,2' -split ',') | Sort-Object) -join ',')
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
