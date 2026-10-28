BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Action', 'SearchTerm', 'UserId', 'Users', 'SearchText', 'Configuration'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = 'Default'; Mandatory = @('TssSession'); Optional = @('Action', 'SearchTerm', 'UserId'); Absent = @('Users', 'SearchText', 'Configuration') }
            @{ CommandName = $commandName; SetName = 'Users'; Mandatory = @('TssSession', 'Users'); Optional = @(); Absent = @('Action', 'SearchTerm', 'UserId', 'SearchText', 'Configuration') }
            @{ CommandName = $commandName; SetName = 'Configuration'; Mandatory = @('TssSession', 'Configuration'); Optional = @('SearchText'); Absent = @('Action', 'SearchTerm', 'UserId', 'Users') }
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
        It "$commandName should declare OutputTypes Thycotic.PowerShell.KeyManagement.AuditUser[],Thycotic.PowerShell.KeyManagement.ConfigurationAudit[],Thycotic.PowerShell.KeyManagement.RotationAudit[]" -TestCases $commandDetails {
            ($_.OutputType.Name | Sort-Object) -join ',' | Should -BeExactly 'Thycotic.PowerShell.KeyManagement.AuditUser[],Thycotic.PowerShell.KeyManagement.ConfigurationAudit[],Thycotic.PowerShell.KeyManagement.RotationAudit[]'
        }
        It "$commandName should default to the Default parameter set" -TestCases $commandDetails {
            $_.DefaultParameterSet | Should -Be 'Default'
        }
        It "$commandName should take TssSession as Thycotic.PowerShell.Authentication.Session" -TestCases $commandDetails {
            $_.Parameters['TssSession'].ParameterType.FullName | Should -Be 'Thycotic.PowerShell.Authentication.Session'
        }
        It "$commandName should take Action as System.String" -TestCases $commandDetails {
            $_.Parameters['Action'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take SearchTerm as System.String" -TestCases $commandDetails {
            $_.Parameters['SearchTerm'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take UserId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['UserId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take Users as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['Users'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take SearchText as System.String" -TestCases $commandDetails {
            $_.Parameters['SearchText'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take Configuration as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['Configuration'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take TssSession from the pipeline (ValueFromPipeline)" -TestCases $commandDetails {
            @($_.Parameters['TssSession'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] -and $_.ValueFromPipeline }).Count | Should -BeGreaterThan 0
        }
        It "$commandName should bind TssSession at position 0" -TestCases $commandDetails {
            @($_.Parameters['TssSession'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] }).Position | Should -Contain 0
        }
        It "$commandName pipeline/output type Thycotic.PowerShell.KeyManagement.RotationAudit should expose MasterEncryptionKeyRotationInfoAuditId as System.Int32" {
            ([type]'Thycotic.PowerShell.KeyManagement.RotationAudit').GetProperty('MasterEncryptionKeyRotationInfoAuditId').PropertyType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName pipeline/output type Thycotic.PowerShell.KeyManagement.RotationAudit should expose UserId as System.Int32" {
            ([type]'Thycotic.PowerShell.KeyManagement.RotationAudit').GetProperty('UserId').PropertyType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName pipeline/output type Thycotic.PowerShell.KeyManagement.AuditUser should expose UserId as System.Int32" {
            ([type]'Thycotic.PowerShell.KeyManagement.AuditUser').GetProperty('UserId').PropertyType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName pipeline/output type Thycotic.PowerShell.KeyManagement.ConfigurationAudit should expose Notes as System.String" {
            ([type]'Thycotic.PowerShell.KeyManagement.ConfigurationAudit').GetProperty('Notes').PropertyType.FullName | Should -Be 'System.String'
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
