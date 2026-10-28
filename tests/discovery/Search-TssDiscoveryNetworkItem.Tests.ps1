BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'CreatedEndDate', 'CreatedStartDate', 'DiscoveryRuleId', 'DiscoverySourceId', 'HasComputerAccounts', 'ItemType', 'LastPolledEndDate', 'LastPolledStartDate', 'LastReachedEndDate', 'LastReachedStartDate', 'Managed', 'OperatingSystem', 'OrganizationalUnitId', 'ScanItemTemplateId', 'SearchChildren', 'SearchText'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession'); Optional = @('CreatedEndDate', 'CreatedStartDate', 'DiscoveryRuleId', 'DiscoverySourceId', 'HasComputerAccounts', 'ItemType', 'LastPolledEndDate', 'LastPolledStartDate', 'LastReachedEndDate', 'LastReachedStartDate', 'Managed', 'OperatingSystem', 'OrganizationalUnitId', 'ScanItemTemplateId', 'SearchChildren', 'SearchText'); Absent = @() }
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
        It "$commandName should set OutputType to Thycotic.PowerShell.Discovery.NetworkItem[]" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.Discovery.NetworkItem[]'
        }
        It "$commandName should take TssSession as Thycotic.PowerShell.Authentication.Session" -TestCases $commandDetails {
            $_.Parameters['TssSession'].ParameterType.FullName | Should -Be 'Thycotic.PowerShell.Authentication.Session'
        }
        It "$commandName should take CreatedEndDate as System.DateTime" -TestCases $commandDetails {
            $_.Parameters['CreatedEndDate'].ParameterType.FullName | Should -Be 'System.DateTime'
        }
        It "$commandName should take CreatedStartDate as System.DateTime" -TestCases $commandDetails {
            $_.Parameters['CreatedStartDate'].ParameterType.FullName | Should -Be 'System.DateTime'
        }
        It "$commandName should take DiscoveryRuleId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['DiscoveryRuleId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take DiscoverySourceId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['DiscoverySourceId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take HasComputerAccounts as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['HasComputerAccounts'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take ItemType as System.String" -TestCases $commandDetails {
            $_.Parameters['ItemType'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should limit ItemType to Computer,ComputerAccount,ServiceAccount,PublicKey,DirectoryAccount,EntraIDRole,EntraIDMember" -TestCases $commandDetails {
            (($_.Parameters['ItemType'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('Computer,ComputerAccount,ServiceAccount,PublicKey,DirectoryAccount,EntraIDRole,EntraIDMember' -split ',') | Sort-Object) -join ',')
        }
        It "$commandName should take LastPolledEndDate as System.DateTime" -TestCases $commandDetails {
            $_.Parameters['LastPolledEndDate'].ParameterType.FullName | Should -Be 'System.DateTime'
        }
        It "$commandName should take LastPolledStartDate as System.DateTime" -TestCases $commandDetails {
            $_.Parameters['LastPolledStartDate'].ParameterType.FullName | Should -Be 'System.DateTime'
        }
        It "$commandName should take LastReachedEndDate as System.DateTime" -TestCases $commandDetails {
            $_.Parameters['LastReachedEndDate'].ParameterType.FullName | Should -Be 'System.DateTime'
        }
        It "$commandName should take LastReachedStartDate as System.DateTime" -TestCases $commandDetails {
            $_.Parameters['LastReachedStartDate'].ParameterType.FullName | Should -Be 'System.DateTime'
        }
        It "$commandName should take Managed as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['Managed'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take OperatingSystem as System.String" -TestCases $commandDetails {
            $_.Parameters['OperatingSystem'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take OrganizationalUnitId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['OrganizationalUnitId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take ScanItemTemplateId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['ScanItemTemplateId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take SearchChildren as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['SearchChildren'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take SearchText as System.String" -TestCases $commandDetails {
            $_.Parameters['SearchText'].ParameterType.FullName | Should -Be 'System.String'
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
