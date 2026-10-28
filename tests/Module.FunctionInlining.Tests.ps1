Describe 'Function files inlined into the released psm1' {
    BeforeAll {
        . "$PSScriptRoot\..\build.functions.ps1"
        $srcRoot = (Resolve-Path "$PSScriptRoot\..\src").Path
        $loader = "#region Import Functions`nforeach (`$file in Get-ChildItem -Path `$PSScriptRoot\functions -Recurse -Filter *-*.ps1) {`n    . `$file.FullName`n}`n#endregion Import Functions`n`$after = `$PSScriptRoot`n"
        function New-StagedModule {
            param([string]$Name, [hashtable]$Files)
            $staged = Join-Path $TestDrive $Name
            New-Item -ItemType Directory -Path "$staged\functions\probe" -Force | Out-Null
            Set-Content -LiteralPath "$staged\Thycotic.SecretServer.psm1" -Value $loader -NoNewline
            foreach ($fileName in $Files.Keys) { Set-Content -LiteralPath "$staged\functions\probe\$fileName" -Value $Files[$fileName] }
            $staged
        }
    }
    It 'inlines every src function in loader order and removes the functions folder' {
        $staged = Join-Path $TestDrive 'src-copy'
        New-Item -ItemType Directory -Path $staged | Out-Null
        Copy-Item -LiteralPath "$srcRoot\Thycotic.SecretServer.psm1" -Destination $staged
        Copy-Item -LiteralPath "$srcRoot\functions" -Destination $staged -Recurse
        $expected = (Get-ChildItem -Path "$staged\functions" -Recurse -Filter '*-*.ps1').BaseName

        { Merge-ModuleFunction -ModulePath $staged } | Should -Not -Throw

        Test-Path "$staged\functions" | Should -BeFalse
        $text = [System.IO.File]::ReadAllText("$staged\Thycotic.SecretServer.psm1")
        $text | Should -Not -Match 'Get-ChildItem -Path \$PSScriptRoot\\functions'
        $parseErrors = $null
        $ast = [System.Management.Automation.Language.Parser]::ParseInput($text, [ref]$null, [ref]$parseErrors)
        $parseErrors | Should -BeNullOrEmpty
        $defined = $ast.EndBlock.Statements | Where-Object { $_ -is [System.Management.Automation.Language.FunctionDefinitionAst] } | ForEach-Object Name
        $defined | Should -Be $expected
    }
    It 'accepts a plain function and leaves psm1 code outside the loader alone' {
        $staged = New-StagedModule -Name 'plain' -Files @{ 'Get-Plain.ps1' = "function Get-Plain {`n    'ok'`n}" }
        { Merge-ModuleFunction -ModulePath $staged } | Should -Not -Throw
        $text = [System.IO.File]::ReadAllText("$staged\Thycotic.SecretServer.psm1")
        $text | Should -Match '#region functions/probe/Get-Plain\.ps1'
        $text | Should -Match '\$after = \$PSScriptRoot'
    }
    It 'rejects <Name> and leaves the staged module unchanged' -ForEach @(
        @{ Name = 'Get-Requires.ps1'; Content = "#requires -Version 7`nfunction Get-Requires { }"; Reason = '#requires' }
        @{ Name = 'Get-Using.ps1'; Content = "using namespace System.IO`nfunction Get-Using { }"; Reason = 'script-level using' }
        @{ Name = 'Get-Param.ps1'; Content = "param(`$x)`nfunction Get-Param { }"; Reason = 'script-level param' }
        @{ Name = 'Get-TopLevel.ps1'; Content = "`$x = 1`nfunction Get-TopLevel { }"; Reason = 'top-level code' }
        @{ Name = 'Get-Two.ps1'; Content = "function Get-Two { }`nfunction Get-Other { }"; Reason = 'does not match' }
        @{ Name = 'Get-Misnamed.ps1'; Content = 'function Get-Different { }'; Reason = 'does not match' }
        @{ Name = 'Get-ScriptRoot.ps1'; Content = "function Get-ScriptRoot { `$PSScriptRoot }"; Reason = 'PSScriptRoot' }
        @{ Name = 'Get-CommandPath.ps1'; Content = "function Get-CommandPath { `$MyInvocation.MyCommand.Path }"; Reason = 'MyCommand.Path' }
    ) {
        $staged = New-StagedModule -Name ($Name -replace '\.ps1$') -Files @{ $Name = $Content }
        { Merge-ModuleFunction -ModulePath $staged } | Should -Throw -ExpectedMessage "*$Name*$Reason*"
        Test-Path "$staged\functions\probe\$Name" | Should -BeTrue
        [System.IO.File]::ReadAllText("$staged\Thycotic.SecretServer.psm1") | Should -Be $loader
    }
}
