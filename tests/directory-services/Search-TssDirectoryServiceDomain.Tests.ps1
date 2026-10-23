BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'DomainName', 'SearchText', 'IncludeInactive', 'SortBy'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
    }
    Context "Verify parameters" -Foreach @{currentParams = $currentParams} {
        It "$commandName should contain <_> parameter" -TestCases $knownParameters {
            $_ -in $currentParams | Should -Be $true
        }
        It "$commandName should not contain parameter: <_>" -TestCases $unknownParameters {
            $_ | Should -BeNullOrEmpty
        }
    }
    Context "Command specific details" {
        It "$commandName should set OutputType to Thycotic.PowerShell.DirectoryServices.DomainSummary[]" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.DirectoryServices.DomainSummary[]'
        }
        It "$commandName should default to parameter set filter" -TestCases $commandDetails {
            $_.DefaultParameterSet | Should -Be 'filter'
        }
        It "$commandName parameter set searchText should require SearchText only" -TestCases $commandDetails {
            $set = $_.ParameterSets.Where({ $_.Name -eq 'searchText' })[0]
            ($set.Parameters.Where({ $_.IsMandatory }).Name | Sort-Object) -join ',' | Should -BeExactly 'SearchText,TssSession'
        }
        It "$commandName parameter set searchText should not offer DomainName or SortBy" -TestCases $commandDetails {
            $set = $_.ParameterSets.Where({ $_.Name -eq 'searchText' })[0]
            $set.Parameters.Name | Should -Not -Contain 'DomainName'
            $set.Parameters.Name | Should -Not -Contain 'SortBy'
        }
        It "$commandName parameter set filter should not offer SearchText" -TestCases $commandDetails {
            $set = $_.ParameterSets.Where({ $_.Name -eq 'filter' })[0]
            $set.Parameters.Name | Should -Not -Contain 'SearchText'
        }
        It "$commandName output type should expose DistinguishedName as System.String and SiteId as a nullable System.Int32" {
            ([type]'Thycotic.PowerShell.DirectoryServices.DomainSummary').GetProperty('DistinguishedName').PropertyType.FullName | Should -Be 'System.String'
            [Nullable]::GetUnderlyingType(([type]'Thycotic.PowerShell.DirectoryServices.DomainSummary').GetProperty('SiteId').PropertyType).FullName | Should -Be 'System.Int32'
        }
    }
}