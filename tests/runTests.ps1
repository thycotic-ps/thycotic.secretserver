switch ($PSEdition) {
    'Desktop' { Write-Host "Testing in Windows PowerShell" -ForegroundColor Black -BackgroundColor DarkBlue }
    'Core' { Write-Host "Testing in PowerShell" -ForegroundColor Black -BackgroundColor DarkBlue}
}
$testRootPath = $PSScriptRoot
$modulePsd1 = [IO.Path]::Combine(($PSScriptRoot.Trim("tests")), 'src\Thycotic.SecretServer.psd1')
$module = Import-Module $modulePsd1 -Force -PassThru

Write-Host "Testing module version $($module.Version)" -BackgroundColor DarkGreen -ForegroundColor Black
try {
    if (-not (Get-Module Pester)) {
        Import-Module Pester -RequiredVersion 5.1.1
    }
} catch {
    Write-Error "Pester 5.1.1 was not imported, please correct"
    return
}

Invoke-Pester -Path $testRootPath -Output Minimal