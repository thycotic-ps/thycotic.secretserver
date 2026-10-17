BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'IncludeInactive', 'SecretId', 'TenantId', 'Id'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = 'filter'; Mandatory = @('TssSession'); Optional = @('IncludeInactive', 'SecretId', 'TenantId'); Absent = @('Id') }
            @{ CommandName = $commandName; SetName = 'id'; Mandatory = @('TssSession', 'Id'); Optional = @(); Absent = @('IncludeInactive', 'SecretId', 'TenantId') }
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
        It "$commandName should declare OutputType Thycotic.PowerShell.DevOpsSecretsVault.DsvSyncStatus[]" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Contain 'Thycotic.PowerShell.DevOpsSecretsVault.DsvSyncStatus[]'
        }
        It "$commandName should declare OutputType Thycotic.PowerShell.DevOpsSecretsVault.DsvSync" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Contain 'Thycotic.PowerShell.DevOpsSecretsVault.DsvSync'
        }
        It "$commandName should declare exactly 2 OutputTypes" -TestCases $commandDetails {
            @($_.OutputType.Name).Count | Should -Be 2
        }
        It "$commandName should default to the filter parameter set" -TestCases $commandDetails {
            $_.DefaultParameterSet | Should -Be 'filter'
        }
        It "$commandName should take TssSession as Thycotic.PowerShell.Authentication.Session" -TestCases $commandDetails {
            $_.Parameters['TssSession'].ParameterType.FullName | Should -Be 'Thycotic.PowerShell.Authentication.Session'
        }
        It "$commandName should take IncludeInactive as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['IncludeInactive'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take SecretId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['SecretId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take TenantId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['TenantId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take Id as System.Int32[]" -TestCases $commandDetails {
            $_.Parameters['Id'].ParameterType.FullName | Should -Be 'System.Int32[]'
        }
        It "$commandName should accept DevOpsSyncMapId as an alias of Id" -TestCases $commandDetails {
            $_.Parameters['Id'].Aliases | Should -Contain 'DevOpsSyncMapId'
        }
        It "$commandName should accept SyncMapId as an alias of Id" -TestCases $commandDetails {
            $_.Parameters['Id'].Aliases | Should -Contain 'SyncMapId'
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
