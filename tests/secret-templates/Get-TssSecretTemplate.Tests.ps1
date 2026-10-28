BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id', 'Detail'
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
        It "$commandName should set OutputType to Thycotic.PowerShell.SecretTemplates.Template" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Contain 'Thycotic.PowerShell.SecretTemplates.Template'
        }
        It "$commandName should set OutputType to Thycotic.PowerShell.SecretTemplates.Detail" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Contain 'Thycotic.PowerShell.SecretTemplates.Detail'
        }
        It "$commandName should set exactly 2 OutputTypes" -TestCases $commandDetails {
            @($_.OutputType).Count | Should -Be 2
        }
        It "$commandName keeps Id mandatory, by property name, aliases TemplateId and SecretTemplateId" -TestCases $commandDetails {
            $p = $_.Parameters['Id']
            $p.ParameterType.FullName | Should -Be 'System.Int32[]'
            $p.Attributes.Where({ $_ -is [System.Management.Automation.ParameterAttribute] }).Mandatory | Should -Be $true
            $p.Attributes.Where({ $_ -is [System.Management.Automation.ParameterAttribute] }).ValueFromPipelineByPropertyName | Should -Be $true
            ($p.Aliases | Sort-Object) -join ',' | Should -Be 'SecretTemplateId,TemplateId'
        }
        It "$commandName -Detail is an optional switch" -TestCases $commandDetails {
            $p = $_.Parameters['Detail']
            $p.ParameterType | Should -Be ([switch])
            $p.Attributes.Where({ $_ -is [System.Management.Automation.ParameterAttribute] }).Mandatory | Should -Be $false
        }
    }
}
