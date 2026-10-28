BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'ChangePassword', 'DiscoverySourceId', 'FolderId', 'ItemId', 'NextPassword', 'Passphrase', 'Password', 'PrivateKey', 'RandomPassword', 'ScanItemTemplateId', 'SecretNameFormat', 'SecretPrivilegedAccount', 'SecretTypeId', 'SiteId', 'TakeOverAccountPasswordTypeId', 'TakeOverAccountSecrets'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession', 'DiscoverySourceId', 'ItemId', 'ScanItemTemplateId', 'SecretNameFormat', 'SecretTypeId', 'SiteId'); Optional = @('ChangePassword', 'FolderId', 'NextPassword', 'Passphrase', 'Password', 'PrivateKey', 'RandomPassword', 'SecretPrivilegedAccount', 'TakeOverAccountPasswordTypeId', 'TakeOverAccountSecrets'); Absent = @() }
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
        It "$commandName should set OutputType to Thycotic.PowerShell.Discovery.BulkOperation" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.Discovery.BulkOperation'
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
        It "$commandName should take ItemId as System.Int32[]" -TestCases $commandDetails {
            $_.Parameters['ItemId'].ParameterType.FullName | Should -Be 'System.Int32[]'
        }
        It "$commandName should take DiscoverySourceId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['DiscoverySourceId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take ScanItemTemplateId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['ScanItemTemplateId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take SecretTypeId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['SecretTypeId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take Password as System.Security.SecureString" -TestCases $commandDetails {
            $_.Parameters['Password'].ParameterType.FullName | Should -Be 'System.Security.SecureString'
        }
        It "$commandName should take NextPassword as System.Security.SecureString" -TestCases $commandDetails {
            $_.Parameters['NextPassword'].ParameterType.FullName | Should -Be 'System.Security.SecureString'
        }
        It "$commandName should take Passphrase as System.Security.SecureString" -TestCases $commandDetails {
            $_.Parameters['Passphrase'].ParameterType.FullName | Should -Be 'System.Security.SecureString'
        }
        It "$commandName should take PrivateKey as System.Security.SecureString" -TestCases $commandDetails {
            $_.Parameters['PrivateKey'].ParameterType.FullName | Should -Be 'System.Security.SecureString'
        }
        It "$commandName should take SecretPrivilegedAccount as System.Int32[]" -TestCases $commandDetails {
            $_.Parameters['SecretPrivilegedAccount'].ParameterType.FullName | Should -Be 'System.Int32[]'
        }
        It "$commandName should take TakeOverAccountSecrets as System.Int32[]" -TestCases $commandDetails {
            $_.Parameters['TakeOverAccountSecrets'].ParameterType.FullName | Should -Be 'System.Int32[]'
        }
        It "$commandName should take ChangePassword as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['ChangePassword'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take RandomPassword as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['RandomPassword'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
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
