param(
    $gallerykey
)
$beta = $true
$moduleName = 'Thycotic.SecretServer'
$staging = "C:\temp\staging\"

if (Test-Path $staging) {
    Remove-Item -Recurse -Force $staging
}
$imported = Import-Module .\src\Thycotic.SecretServer.psd1 -Force -PassThru

try {
    Import-Module Pester
    Invoke-Pester -Path "$PSScriptRoot\tests" -Output Minimal
} catch {
    if ($_.FullQualifiedErrorId -contains 'PesterAssertionFailed') {
        throw "Pester test failed: $_"
    }
}

$foundModule = Find-Module -Name $moduleName -AllowPrerelease:$beta
if ($foundModule.Version -ge $imported.Version) {
    Write-Warning "PowerShell Gallery version of $moduleName is more recent ($($foundModule.Version) >= $($imported.Version))"
} else {
    $moduleTempPath = Join-Path $staging $moduleName
    Write-Host "Staging directory: $moduleTempPath"
    $imported | Split-Path | Copy-Item -Destination $moduleTempPath -Recurse

    Write-Host "Module Files:"
    Get-ChildItem $moduleTempPath -Recurse | Select-Object Directory, Name

    Write-Host "Publishing $moduleName [$($imported.Version)] to PowerShell Gallery"
    try {
        Publish-Module -Path $moduleTempPath -NuGetApiKey $gallerykey
        Write-Host "successfully published - mock"
    } catch {
        throw "Publish to PowerShell Gallery failed: $($_.Exception.Message)"
    }

    if ($?) {
        Write-Host "Published to PowerShell Gallery"
        Remove-Item -Recurse -Force $staging
    } else {
        throw "PowerShell Gallery Publish Failed"
    }
}