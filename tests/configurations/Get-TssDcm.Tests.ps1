BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Type', 'CurrentUser', 'Mobile'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = 'type'; Mandatory = @('TssSession', 'Type'); Optional = @(); Absent = @('CurrentUser', 'Mobile') }
            @{ CommandName = $commandName; SetName = 'currentUser'; Mandatory = @('TssSession', 'CurrentUser'); Optional = @(); Absent = @('Type', 'Mobile') }
            @{ CommandName = $commandName; SetName = 'mobile'; Mandatory = @('TssSession', 'Mobile'); Optional = @(); Absent = @('Type', 'CurrentUser') }
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
        It "$commandName should declare OutputTypes Thycotic.PowerShell.Configuration.Dcm,Thycotic.PowerShell.Configuration.DcmCurrentUser,Thycotic.PowerShell.Configuration.DcmMobile" -TestCases $commandDetails {
            ($_.OutputType.Name | Sort-Object) -join ',' | Should -BeExactly 'Thycotic.PowerShell.Configuration.Dcm,Thycotic.PowerShell.Configuration.DcmCurrentUser,Thycotic.PowerShell.Configuration.DcmMobile'
        }
        It "$commandName should default to the type parameter set" -TestCases $commandDetails {
            $_.DefaultParameterSet | Should -Be 'type'
        }
        It "$commandName should take TssSession as Thycotic.PowerShell.Authentication.Session" -TestCases $commandDetails {
            $_.Parameters['TssSession'].ParameterType.FullName | Should -Be 'Thycotic.PowerShell.Authentication.Session'
        }
        It "$commandName should take Type as System.String" -TestCases $commandDetails {
            $_.Parameters['Type'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take CurrentUser as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['CurrentUser'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take Mobile as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['Mobile'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should limit Type to BusinessUser,UnrestrictedUser" -TestCases $commandDetails {
            (($_.Parameters['Type'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('BusinessUser,UnrestrictedUser' -split ',') | Sort-Object) -join ',')
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
