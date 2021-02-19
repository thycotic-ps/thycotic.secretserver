BeforeDiscovery {
    $ModuleRoot = (Resolve-Path "$PSScriptRoot\..\src").Path
    $ModuleName = (Get-ChildItem "$ModuleRoot\*.psd1").Name.Trim(".psd1")
    $CommandPath = "$ModuleRoot\functions"

    $includedNames = (Get-ChildItem $CommandPath -Recurse -File | Where-Object Name -like "*.ps1").BaseName
    $commands = Get-Command -Module $ModuleName -CommandType Function | Where-Object Name -In $includedNames

    $commonParams = [System.Management.Automation.PSCmdlet]::CommonParameters
    $optionalParam = [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
}
Describe "Test help for module" -ForEach $commands {
    BeforeDiscovery {
        $commandName = $_.Name
        $help = Get-Help $_.Name
        $examples = $help.Examples.example | Select-Object code, introduction, remarks, title
        $parameters = $help.parameters.parameter | Where-Object {$_.Name -notin $commonParams -and $_.Name -notin $optionalParam}
    }
    Context "Testing $commandName" -Foreach @{help = $help} {
        It "Should not be auto-generated help" {
            $help.Synopsis | Should -Not -BeLike "*<CommonParameters>*"
        }
        It "Should have a Synopsis" {
            $help.Synopsis | Should -Not -BeNullOrEmpty
        }
        It "Should have a Description" {
            $help.Description | Should -Not -BeNullOrEmpty
        }
        It "Should have an Example" {
            $help.examples | Select-Object -First 1 | Should -HaveCount 1
        }
        It "<_.title -replace '-',''> Should have remarks" -TestCases $examples {
            $_.remarks.Text | Should -Not -BeNullOrEmpty
        }
        It "Parameter <_.Name> has a Description" -TestCases $parameters {
            $_.description.text | Should -Not -BeNullOrEmpty
        }
    }
}