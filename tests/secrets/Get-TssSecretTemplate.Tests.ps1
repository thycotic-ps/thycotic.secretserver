BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id', 'Raw'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName, 'Function')).Parameters.Keys
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
        It "$commandName should set OutputType to TssSecretTemplate" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'TssSecretTemplate'
        }
    }
}
Describe "$commandName works" {
    BeforeDiscovery {
        $session = New-TssSession -SecretServer $ss -Credential $ssCred
        $object = Get-TssSecretTemplate $session -Id 6004
        $session.SessionExpire()

        $props = 'Id','Name','PasswordTypeId','Fields'
    }
    Context "Checking" -Foreach @{object = $object} {
        It "Should not be empty" {
            $object | Should -Not -BeNullOrEmpty
        }
        It "Should output <_> property" -TestCases $props {
            $object.PSObject.Properties.Name | Should -Contain $_
        }
        It "Should have ExposeForDisplay alias property" {
            ($object.Fields | Get-Member -MemberType AliasProperty).Name | Should -Contain 'ExposeForDisplay'
        }
    }
}