Describe 'Versioned ApiUrl rewrites' {
    BeforeAll {
        $functionRoot = (Resolve-Path "$PSScriptRoot\..\src\functions").Path
        $preexistingUnanchoredFiles = 'Search-TssConfigurationBackupLog.ps1', 'Search-TssSystemLog.ps1'
        $rewritePattern = "ApiUrl\s*-[ci]?replace\s*['""]([^'""]*)['""]"
        function Get-UnanchoredRewrite {
            param([System.IO.FileInfo[]]$File)
            foreach ($f in $File) {
                $text = [System.IO.File]::ReadAllText($f.FullName)
                foreach ($m in [regex]::Matches($text, $rewritePattern)) {
                    if ($m.Groups[1].Value -notmatch 'v1\$$') {
                        "$($f.Name): $($m.Value)"
                    }
                }
            }
        }
        $allFiles = Get-ChildItem -Path $functionRoot -Recurse -Filter '*.ps1'
    }
    It 'every function rewrites ApiUrl only with a pattern anchored at the end of /api/v1' {
        $checked = $allFiles | Where-Object Name -NotIn $preexistingUnanchoredFiles
        @(Get-UnanchoredRewrite -File $checked) | Should -BeNullOrEmpty
    }
    It 'still finds the pre-existing unanchored rewrites that are left for a separate fix' {
        $known = $allFiles | Where-Object Name -In $preexistingUnanchoredFiles
        @($known).Count | Should -Be $preexistingUnanchoredFiles.Count
        foreach ($f in $known) {
            @(Get-UnanchoredRewrite -File $f).Count | Should -BeGreaterThan 0 -Because "$($f.Name) leaves the allowlist once its rewrite is anchored"
        }
    }
    It 'flags an unanchored rewrite and accepts an anchored one' {
        $probe = Join-Path $TestDrive 'Probe.ps1'
        Set-Content -LiteralPath $probe -Value @(
            "`$uri = (`$TssSession.ApiUrl -replace 'v1','v2'), 'x' -join '/'"
            "`$uri = (`$TssSession.ApiUrl -replace '/api/v1`$','/api/v2'), 'y' -join '/'"
        )
        @(Get-UnanchoredRewrite -File (Get-Item -LiteralPath $probe)).Count | Should -Be 1
    }
}
