[cmdletbinding()]
param(
    [ValidateSet('Debug','Release')]
    [string]
    $Configuration = 'Release'
)

$script:ModuleManifest = [IO.Path]::Combine($PSScriptRoot,'src','Thycotic.SecretServer.psd1')
$script:ProjectRoot = [IO.Path]::Combine($PSScriptRoot,'src','Thycotic.SecretServer')
$script:ProjectFile = [IO.Path]::Combine($ProjectRoot, 'Thycotic.SecretServer.csproj')
$script:ProjectOut = [IO.Path]::Combine($PSScriptRoot,'src','bin')
$script:ProjectLibFile = [IO.Path]::Combine($ProjectOut,'Thycotic.SecretServer.dll')
$script:Manifest = Import-PowerShellDataFile -Path $ModuleManifest
$script:Version = $Manifest.ModuleVersion

# Ensure and call the module.
if ($MyInvocation.ScriptName -notlike '*Invoke-Build.ps1') {
    $InvokeBuildVersion = '5.7.3'
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

task Clean -Before Build {
    if (Test-Path $ProjectLibFile) {
        Remove-Item $ProjectLibFile
    }
}

task Build {
    exec { dotnet build --configuration $Configuration --output $ProjectOut /p:Version=$Version $ProjectFile }
}

task . build