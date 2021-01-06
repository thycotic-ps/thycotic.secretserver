BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id', 'All', 'Raw'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
    }
    Context "Verify parmaeters" -Foreach @{currentParams = $currentParams} {
        It "$commandName should contain <_> parameter" -TestCases $knownParameters {
            $_ -in $currentParams | Should -Be $true
        }
        It "$commandName should not contain parameter: <_>" -TestCases $unknownParameters {
            $_ | Should -BeNullOrEmpty
        }
    }
    Context "Command specific details" {
        It "$commandName should set OutputType to TssReportCategory" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'TssReportCategory'
        }
    }
}
Describe "$commandName works" {
    BeforeDiscovery {
        $session = New-TssSession -SecretServer $ss -Credential $ssCred
        $objectId = Get-TssReportCategory -TssSession $session -Id 4
        $objectAll = Get-TssReportCategory -TssSession $session -All
        $session.SessionExpire()
        $props = 'CategoryId', 'Name', 'Description'
    }
    Context "Checking Id" -Foreach @{object = $objectId} {
        It "Should not be empty" {
            $object | Should -Not -BeNullOrEmpty
        }
        It "Should output <_> property" -TestCases $props {
            $object.PSObject.Properties.Name | Should -Contain $_
        }
    }
    Context "Checking All" -Foreach @{object = $objectAll} {
        It "Should not be empty" {
            $object | Should -Not -BeNullOrEmpty
        }
        It "Should contain more than one object" {
            $object.Count | Should -BeGreaterThan 1
        }
        It "Should output <_> property" -TestCases $props {
            $object[0].PSObject.Properties.Name | Should -Contain $_
        }
    }
}