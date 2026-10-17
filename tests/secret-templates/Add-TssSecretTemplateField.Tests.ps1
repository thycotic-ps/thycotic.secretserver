BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id', 'Field', 'Name', 'FieldSlugName', 'Description', 'DataType'
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
        It "$commandName should set OutputType to Thycotic.PowerShell.SecretTemplates.FieldDetail" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.SecretTemplates.FieldDetail'
        }
        It "$commandName should support ShouldProcess with ConfirmImpact Medium" -TestCases $commandDetails {
            $binding = $_.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }
            $binding.SupportsShouldProcess | Should -Be $true
            $binding.ConfirmImpact | Should -Be 'Medium'
        }
        It "$commandName keeps Field mandatory at position 2 and Id at position 1" -TestCases $commandDetails {
            $f = $_.Parameters['Field']
            $f.ParameterType.FullName | Should -Be 'Thycotic.PowerShell.SecretTemplates.Field'
            $fa = $f.Attributes.Where({ $_ -is [System.Management.Automation.ParameterAttribute] })
            $fa.Mandatory | Should -Not -Contain $false
            $fa.Position | Should -Be 2
            $_.Parameters['Id'].Attributes.Where({ $_ -is [System.Management.Automation.ParameterAttribute] }).Position | Should -Be 1
        }
        It "$commandName makes the Field set the default parameter set" -TestCases $commandDetails {
            $_.DefaultParameterSet | Should -Be 'Default'
            'Field' -in ($_.ParameterSets | Where-Object Name -eq 'Default').Parameters.Name | Should -Be $true
        }
        It "$commandName set Name requires Name and FieldSlugName and excludes Field" -TestCases $commandDetails {
            $set = $_.ParameterSets | Where-Object Name -eq 'Name'
            (($set.Parameters | Where-Object IsMandatory).Name | Sort-Object) -join ',' | Should -Be 'FieldSlugName,Id,Name,TssSession'
            'Field' -in $set.Parameters.Name | Should -Be $false
        }
    }
}
