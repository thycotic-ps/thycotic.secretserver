BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id', 'NewPassword', 'Comment', 'TicketNumber', 'TicketSystemId', 'DoubleLockPassword', 'ForceCheckIn', 'IncludeInactive', 'NoAutoCheckout', 'IsForceCheckoutRequestApproval', 'PreventFurtherRetriesAfterMaxAttempts', 'GenerateSshKeys', 'GeneratePassphrase', 'PrivateKey', 'Passphrase', 'AutoCheckIn', 'AutoCheckout', 'AutoComment'
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
        It "$commandName should set OutputType to Thycotic.PowerShell.Secrets.Summary" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.Secrets.Summary'
        }
        It "$commandName should support ShouldProcess" -TestCases $commandDetails {
            $_.Parameters.ContainsKey('WhatIf') | Should -Be $true
        }
        It "$commandName should set ConfirmImpact to Medium" -TestCases $commandDetails {
            ($_.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }).ConfirmImpact | Should -Be 'Medium'
        }
        It "$commandName should accept SecretId as an alias of Id" -TestCases $commandDetails {
            $_.Parameters['Id'].Aliases | Should -Contain 'SecretId'
        }
        It "$commandName should take Id from the pipeline by property name" -TestCases $commandDetails {
            @($_.Parameters['Id'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] -and $_.ValueFromPipelineByPropertyName }).Count | Should -BeGreaterThan 0
        }
        It "$commandName should take Id as System.Int32[]" -TestCases $commandDetails {
            $_.Parameters['Id'].ParameterType.FullName | Should -Be 'System.Int32[]'
        }
        It "$commandName should take NewPassword as System.Security.SecureString" -TestCases $commandDetails {
            $_.Parameters['NewPassword'].ParameterType.FullName | Should -Be 'System.Security.SecureString'
        }
        It "$commandName should take Comment as System.String" -TestCases $commandDetails {
            $_.Parameters['Comment'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take TicketNumber as System.String" -TestCases $commandDetails {
            $_.Parameters['TicketNumber'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take TicketSystemId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['TicketSystemId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take DoubleLockPassword as System.Security.SecureString" -TestCases $commandDetails {
            $_.Parameters['DoubleLockPassword'].ParameterType.FullName | Should -Be 'System.Security.SecureString'
        }
        It "$commandName should take ForceCheckIn as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['ForceCheckIn'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take IncludeInactive as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['IncludeInactive'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take NoAutoCheckout as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['NoAutoCheckout'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take IsForceCheckoutRequestApproval as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['IsForceCheckoutRequestApproval'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take PreventFurtherRetriesAfterMaxAttempts as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['PreventFurtherRetriesAfterMaxAttempts'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take GenerateSshKeys as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['GenerateSshKeys'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take GeneratePassphrase as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['GeneratePassphrase'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take PrivateKey as System.String" -TestCases $commandDetails {
            $_.Parameters['PrivateKey'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take Passphrase as System.Security.SecureString" -TestCases $commandDetails {
            $_.Parameters['Passphrase'].ParameterType.FullName | Should -Be 'System.Security.SecureString'
        }
        It "$commandName should take AutoCheckIn as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['AutoCheckIn'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take AutoCheckout as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['AutoCheckout'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take AutoComment as System.String" -TestCases $commandDetails {
            $_.Parameters['AutoComment'].ParameterType.FullName | Should -Be 'System.String'
        }
    }
    BeforeDiscovery {
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession', 'Id'); Optional = @('NewPassword', 'Comment', 'TicketNumber', 'TicketSystemId', 'DoubleLockPassword', 'ForceCheckIn', 'IncludeInactive', 'NoAutoCheckout', 'IsForceCheckoutRequestApproval', 'PreventFurtherRetriesAfterMaxAttempts', 'GenerateSshKeys', 'GeneratePassphrase', 'PrivateKey', 'Passphrase', 'AutoCheckIn', 'AutoCheckout', 'AutoComment'); Absent = @() }
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
