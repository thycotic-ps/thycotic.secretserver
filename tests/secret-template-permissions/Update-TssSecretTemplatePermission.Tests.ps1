BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'GroupId', 'RoleId', 'SecretTemplateId', 'Id'
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
        It "$commandName should set OutputType to Thycotic.PowerShell.SecretTemplatePermissions.GroupPermission" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Contain 'Thycotic.PowerShell.SecretTemplatePermissions.GroupPermission'
        }
        It "$commandName should set OutputType to Thycotic.PowerShell.SecretTemplates.Result" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Contain 'Thycotic.PowerShell.SecretTemplates.Result'
        }
        It "$commandName should set exactly 2 OutputTypes" -TestCases $commandDetails {
            @($_.OutputType).Count | Should -Be 2
        }
        It "$commandName should support ShouldProcess with ConfirmImpact Medium" -TestCases $commandDetails {
            $binding = $_.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }
            $binding.SupportsShouldProcess | Should -Be $true
            $binding.ConfirmImpact | Should -Be 'Medium'
        }
    }
}
