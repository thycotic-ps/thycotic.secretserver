BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id', 'SearchTerm', 'Assigned', 'DomainId', 'UserStatus'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession', 'Id'); Optional = @('SearchTerm', 'Assigned', 'DomainId', 'UserStatus'); Absent = @() }
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
        It "$commandName should set OutputType to Thycotic.PowerShell.Groups.MemberSummary[]" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.Groups.MemberSummary[]'
        }
        It "$commandName should take Id as System.Int32[]" -TestCases $commandDetails {
            $_.Parameters['Id'].ParameterType.FullName | Should -Be 'System.Int32[]'
        }
        It "$commandName should take SearchTerm as System.String" -TestCases $commandDetails {
            $_.Parameters['SearchTerm'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take Assigned as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['Assigned'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take DomainId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['DomainId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take UserStatus as System.String" -TestCases $commandDetails {
            $_.Parameters['UserStatus'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should limit UserStatus to EnabledAndDisabled,Enabled,Disabled" -TestCases $commandDetails {
            (($_.Parameters['UserStatus'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('EnabledAndDisabled,Enabled,Disabled' -split ',') | Sort-Object) -join ',')
        }
        It "$commandName should accept GroupId as an alias of Id" -TestCases $commandDetails {
            $_.Parameters['Id'].Aliases | Should -Contain 'GroupId'
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
