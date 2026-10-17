BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Completed', 'DayRange', 'SearchText', 'ChallengeType'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession'); Optional = @('Completed', 'DayRange', 'SearchText', 'ChallengeType'); Absent = @() }
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
        It "$commandName should set OutputType to Thycotic.PowerShell.PbaConfiguration.Challenge[]" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.PbaConfiguration.Challenge[]'
        }
        It "$commandName should take TssSession as Thycotic.PowerShell.Authentication.Session" -TestCases $commandDetails {
            $_.Parameters['TssSession'].ParameterType.FullName | Should -Be 'Thycotic.PowerShell.Authentication.Session'
        }
        It "$commandName should take Completed as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['Completed'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take DayRange as System.Int32" -TestCases $commandDetails {
            $_.Parameters['DayRange'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take SearchText as System.String" -TestCases $commandDetails {
            $_.Parameters['SearchText'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take ChallengeType as System.Int64" -TestCases $commandDetails {
            $_.Parameters['ChallengeType'].ParameterType.FullName | Should -Be 'System.Int64'
        }
        It "$commandName should take TssSession from the pipeline (ValueFromPipeline)" -TestCases $commandDetails {
            @($_.Parameters['TssSession'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] -and $_.ValueFromPipeline }).Count | Should -BeGreaterThan 0
        }
        It "$commandName should bind TssSession at position 0" -TestCases $commandDetails {
            @($_.Parameters['TssSession'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] }).Position | Should -Contain 0
        }
        It "$commandName pipeline/output type Thycotic.PowerShell.PbaConfiguration.Challenge should expose SecurityAnalyticsChallengeId as System.Int32" {
            ([type]'Thycotic.PowerShell.PbaConfiguration.Challenge').GetProperty('SecurityAnalyticsChallengeId').PropertyType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName pipeline/output type Thycotic.PowerShell.PbaConfiguration.Challenge should expose ChallengeType as System.Int64" {
            ([type]'Thycotic.PowerShell.PbaConfiguration.Challenge').GetProperty('ChallengeType').PropertyType.FullName | Should -Be 'System.Int64'
        }
        It "$commandName pipeline/output type Thycotic.PowerShell.PbaConfiguration.Challenge should expose UserId as System.Int32" {
            ([type]'Thycotic.PowerShell.PbaConfiguration.Challenge').GetProperty('UserId').PropertyType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName pipeline/output type Thycotic.PowerShell.PbaConfiguration.Challenge should expose ChallengeTypeName as System.String" {
            ([type]'Thycotic.PowerShell.PbaConfiguration.Challenge').GetProperty('ChallengeTypeName').PropertyType.FullName | Should -Be 'System.String'
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
