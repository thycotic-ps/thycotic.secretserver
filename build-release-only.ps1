[cmdletbinding()]
param(
    [ValidateSet('Debug','Release')]
    [string]
    $Configuration = 'Release'
)

if ($PSEdition -eq 'Desktop') {
    throw "Build process must be run using PowerShell 7"
}

if ($MyInvocation.ScriptName -notlike '*Invoke-Build.ps1') {
    $InvokeBuildVersion = '5.8.4'
    $ErrorActionPreference = 'Stop'
    try {
        Import-Module InvokeBuild -RequiredVersion $InvokeBuildVersion
    } catch {
        Install-Module InvokeBuild -RequiredVersion $InvokeBuildVersion -Scope AllUsers -Force
        Import-Module InvokeBuild -RequiredVersion $InvokeBuildVersion
    }
    Invoke-Build -Task $Tasks -File $MyInvocation.MyCommand.Path @PSBoundParameters
    return
}

$moduleName = 'Thycotic.SecretServer'
$moduleManifest = [IO.Path]::Combine($PSScriptRoot,'src',"$ModuleName.psd1")
$libraryFolderName = 'Thycotic.SecretServer'
$staging = [IO.Path]::Combine($PSScriptRoot, 'release_dir')
$libraryBuildScript = [IO.Path]::Combine($PSScriptRoot, 'build.library.ps1')
$zipFilePath = Join-Path $staging "$moduleName.zip"
$moduleTempPath = Join-Path $staging $moduleName

task UpdateManifest -Before stage, build {
    $manifestData = Import-PowerShellDataFile $moduleManifest
    $functionsToExportList = Get-ChildItem .\src\functions -File -Recurse | Select-Object -ExpandProperty BaseName | Sort-Object

    $updateManifestParams = @{
        Path                 = $moduleManifest
        CompatiblePSEditions = $manifestData.CompatiblePSEditions
        RootModule           = $manifestData.RootModule
        Guid                 = $manifestData.Guid
        TypesToProcess       = $manifestData.TypesToProcess
        CmdletsToExport      = $manifestData.CmdletsToExport
        PowerShellVersion    = $manifestData.PowerShellVersion
        CompanyName          = $manifestData.CompanyName
        ModuleVersion        = $manifestData.ModuleVersion
        FunctionsToExport    = $functionsToExportList
        Author               = $manifestData.Author
        Description          = $manifestData.Description
        FormatsToProcess     = $manifestData.FormatsToProcess
        Copyright            = $manifestData.Copyright
        Tags                 = $manifestData.PrivateData.PSData.Tags
        IconUri              = $manifestData.PrivateData.PSData.IconUri
        ProjectUri           = $manifestData.PrivateData.PSData.ProjectUri
        LicenseUri           = $manifestData.PrivateData.PSData.LicenseUri
        ReleaseNotes         = $manifestData.PrivateData.PSData.ReleaseNotes
    }
    Update-ModuleManifest @updateManifestParams
}

task library -Before stage, build {
    Invoke-Build -File $libraryBuildScript
}

task stage -Before build {
    if ($Configuration -ne 'Debug') {
        if (Test-Path $staging) {
            Remove-Item -Recurse -Force $staging
            New-Item -ItemType Directory -Force -Path $staging >$null
        } else {
            New-Item -ItemType Directory -Force -Path $staging >$null
        }

        $script:imported = Import-Module $moduleManifest -Force -PassThru

        Write-Output "Staging directory: $moduleTempPath"
        $imported | Split-Path | Copy-Item -Destination $moduleTempPath -Recurse

        # remove project files
        Remove-Item -Recurse "$moduleTempPath\$libraryFolderName" -Force
        $script:moduleData = Import-PowerShellDataFile $moduleManifest
    } else {
        Write-Output "Debug mode, skipping staging"
    }
}

task build {
    Write-Output "Build started: $(Get-Date -Format FileDateTime)"
    if ($Configuration -ne 'Debug') {
        Compress-Archive "$staging\$moduleName\*" -DestinationPath $zipFilePath -CompressionLevel Fastest -Force
    }
}

task . build