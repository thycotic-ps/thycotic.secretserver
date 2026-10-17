BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'ChallengeEnabled', 'ChallengeLockoutIntegratedEnabled', 'ChallengeLockoutSamlEnabled', 'Enabled', 'EncryptionEnabled', 'EventDataUploadInterval', 'EventDataUploadSizeThreshold', 'ExternalPbaUrl', 'FileUploadEnabled', 'MetadataInterval', 'PbaIntegrationKey', 'RespectOwnerEditorRequireApprovalEnabled', 'RetentionDays', 'SiteId', 'StorageDirectoryPath'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession'); Optional = @('ChallengeEnabled', 'ChallengeLockoutIntegratedEnabled', 'ChallengeLockoutSamlEnabled', 'Enabled', 'EncryptionEnabled', 'EventDataUploadInterval', 'EventDataUploadSizeThreshold', 'ExternalPbaUrl', 'FileUploadEnabled', 'MetadataInterval', 'PbaIntegrationKey', 'RespectOwnerEditorRequireApprovalEnabled', 'RetentionDays', 'SiteId', 'StorageDirectoryPath'); Absent = @() }
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
        It "$commandName should set OutputType to Thycotic.PowerShell.PbaConfiguration.Configuration" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.PbaConfiguration.Configuration'
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
        It "$commandName should take ChallengeEnabled as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['ChallengeEnabled'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take ChallengeLockoutIntegratedEnabled as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['ChallengeLockoutIntegratedEnabled'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take ChallengeLockoutSamlEnabled as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['ChallengeLockoutSamlEnabled'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take Enabled as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['Enabled'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take EncryptionEnabled as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['EncryptionEnabled'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take EventDataUploadInterval as System.Int32" -TestCases $commandDetails {
            $_.Parameters['EventDataUploadInterval'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take EventDataUploadSizeThreshold as System.Int32" -TestCases $commandDetails {
            $_.Parameters['EventDataUploadSizeThreshold'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take ExternalPbaUrl as System.String" -TestCases $commandDetails {
            $_.Parameters['ExternalPbaUrl'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take FileUploadEnabled as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['FileUploadEnabled'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take MetadataInterval as System.Int32" -TestCases $commandDetails {
            $_.Parameters['MetadataInterval'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take PbaIntegrationKey as System.Security.SecureString" -TestCases $commandDetails {
            $_.Parameters['PbaIntegrationKey'].ParameterType.FullName | Should -Be 'System.Security.SecureString'
        }
        It "$commandName should take RespectOwnerEditorRequireApprovalEnabled as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['RespectOwnerEditorRequireApprovalEnabled'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take RetentionDays as System.Int32" -TestCases $commandDetails {
            $_.Parameters['RetentionDays'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take SiteId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['SiteId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take StorageDirectoryPath as System.String" -TestCases $commandDetails {
            $_.Parameters['StorageDirectoryPath'].ParameterType.FullName | Should -Be 'System.String'
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
