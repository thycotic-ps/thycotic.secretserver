BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id', 'Name'
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
        It "$commandName should set OutputType to Thycotic.PowerShell.SecretTemplates.Detail" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.SecretTemplates.Detail'
        }
        It "$commandName should support ShouldProcess with ConfirmImpact Medium" -TestCases $commandDetails {
            $binding = $_.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }
            $binding.SupportsShouldProcess | Should -Be $true
            $binding.ConfirmImpact | Should -Be 'Medium'
        }
        It "$commandName should require Name" -TestCases $commandDetails {
            $mandatory = $_.Parameters['Name'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] } | ForEach-Object Mandatory
            $mandatory | Should -Not -Contain $false
            $mandatory | Should -Contain $true
        }
    }
}
