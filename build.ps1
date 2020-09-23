param(
    $gallerykey
)
$beta = $true
$moduleName = 'Thycotic.SecretServer'
$staging = "C:\temp\staging\"

if (Test-Path $staging) {
    Remove-Item -Recurse -Force $staging
}
$imported = Import-Module .\Thycotic.SecretServer.psd1 -Force -PassThru
$foundModule = Find-Module -Name $moduleName -AllowPrerelease:$beta

if ($foundModule.Version -ge $imported.Version) {
    Write-Warning "PowerShell Gallery version of $moduleName is more recent ($($foundModule.Version) >= $($imported.Version))"
} else {
    $moduleTempPath = Join-Path $staging $moduleName

    Write-Host "Staging directory: $moduleTempPath"
    $imported | Split-Path | Copy-Item -Destination $moduleTempPath -Recurse

    $moduleGitpath = Join-Path $moduleTempPath '.git'
    $moduleGitIgnore = Join-Path $moduleTempPath '.gitignore'
    $moduleDebugLog = Join-Path $moduleTempPath 'debug.log'
    $moduleVscPath = Join-Path $moduleTempPath '.vscode'
    $moduleBuildScript = Join-Path $moduleTempPath 'build.ps1'
    $moduleTests = Join-Path $moduleTempPath 'tests'
    $moduleReadme = Join-Path $moduleTempPath 'README.md'

    if (Test-Path $moduleReadme) {
        Write-Host "Removing README.md directory"
        Remove-Item -Recurse -Force $moduleReadme
    }
    if (Test-Path $moduleGitPath) {
        Write-Host "Removing .git directory"
        Remove-Item -Recurse -Force $moduleGitpath
    }
    if (Test-Path $moduleGitIgnore) {
        Write-Host "Removing .gitignore file"
        Remove-Item -Recurse -Force $moduleGitIgnore
    }
    if (Test-Path $moduleDebugLog) {
        Write-Host "Removing debug.log file"
        Remove-Item -Recurse -Force $moduleDebugLog
    }
    if (Test-Path $moduleVscPath) {
        Write-Host "Removing .vscode directory"
        Remove-Item -Recurse -Force $moduleVscPath
    }
    if (Test-Path $moduleTests) {
        Write-Host "Removing tests directory"
        Remove-Item -Recurse -Force $moduleTests
    }
    if (Test-Path $moduleBuildScript) {
        Write-Host "Removing build script"
        Remove-Item -Recurse -Force $moduleBuildScript
    }

    Write-Host "Module Files:"
    Get-ChildItem $moduleTempPath -Recurse | Select-Object Directory, Name

    Write-Host "Publishing $moduleName [$($imported.Version)] to PowerShell Gallery"
    try {
        Publish-Module -Path $moduleTempPath -NuGetApiKey $gallerykey
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