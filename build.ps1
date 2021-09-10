[cmdletbinding()]
param(
    [ValidateSet('Debug','Release','Prerelease','PSGalleryRetry')]
    [string]
    $Configuration,

    [ValidateScript({ $_ -match '^alpha' })]
    [string]
    $GitHubPreTag,

    [string]
    $GalleryKey
)
if ($PSEdition -eq 'Desktop') {
    throw "Build process must be run using PowerShell 7"
}
# Ensure and call the module.
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
$docRoot = [IO.Path]::Combine($PSScriptRoot, 'docs', 'commands')
$functionsRoot = [IO.Path]::Combine($PSScriptRoot, 'src', 'functions')
$cmdletsRoot = [IO.Path]::Combine($PSScriptRoot, 'src', 'Thycotic.SecretServer', 'cmdlets')
$helpPath = [IO.Path]::Combine($PSScriptRoot, 'src', 'en-us')
$externalHelpFile = [IO.Path]::Combine($helpPath, 'Thycotic.SecretServer.dll-Help.xml')
$libraryBuildScript = [IO.Path]::Combine($PSScriptRoot, 'build.library.ps1')

$zipFilePath = Join-Path $staging "$moduleName.zip"
$zipFileName = "$($moduleName).zip"

$moduleTempPath = Join-Path $staging $moduleName
$changeLog = [IO.Path]::Combine([string]$PSScriptRoot, 'release.md')

task UpdateManifest -Before stage, build, docs {
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

task library -Before stage, build, docs {
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

task docs {
    if (-not (Get-Module platyPs -List)) {
        Write-Output "platyPs module not found, attempting to install"
        try {
            Install-Module platyPs -Scope AllUsers -Force
        } catch {
            throw "Unable to install platyPs module: $($_)"
        }
    }
    Import-Module platyPS

    $script:imported = Import-Module $moduleManifest -Force -PassThru

    $functionDirectories = [IO.Directory]::GetDirectories($functionsRoot)
    $docFunctionsParams = @{
        Module      = $moduleName
        CommandType = 'Function'
    }
    $functions = Get-Command @docFunctionsParams

    $cmdletDirectories = [IO.Directory]::GetDirectories($cmdletsRoot)
    $docCmdletParams = @{
        Module      = $moduleName
        CommandType = 'Cmdlet'
    }
    $cmdlets = Get-Command @docCmdletParams

    Write-Output "Working on functions [$($functions.Count)]"
    foreach ($fDir in $functionDirectories) {
        $categoryFolderName = Split-Path $fDir -Leaf
        $docCommandPath = [IO.Path]::Combine($docRoot,$categoryFolderName)

        if (-not (Test-Path $docCommandPath)) {
            Write-Output "Doc path does not exist: [$docCommandPath], creating"
            New-Item $docCommandPath -ItemType Directory >$null
        }
        $helpNames = Get-ChildItem $fDir -File
        Get-ChildItem $docCommandPath -Filter *.md -Exclude readme.md | Remove-Item -Force -ErrorAction SilentlyContinue
        $helpCommands = $functions.Where({ $_.Name -in $helpNames.BaseName })
        $helpCommands.foreach({
                New-MarkdownHelp -OutputFolder $docCommandPath -Command $_.Name -NoMetadata -Force >$null
            })
    }

    Write-Output "Working on cmdlets [$($cmdlets.Count)]"
    if (Test-Path $externalHelpFile) {
        Remove-Item $externalHelpFile -Force
    }
    $cmdletDocPaths = @()
    foreach ($cDir in $cmdletDirectories) {
        if ($cDir -match 'private') { continue }
        $categoryFolder = Split-Path $cDir -Leaf
        $docCommandPath = [IO.Path]::Combine($docRoot, $categoryFolder)

        if (Test-Path $docCommandPath) {
            $cmdletDocPaths += $docCommandPath
            Update-MarkdownHelp -Path $docCommandPath >$null
        } else {
            Write-Error "Doc path does not exist: $docCommandPath"
        }
    }
    if ($cmdletDocPaths.Count -gt 0) {
        New-ExternalHelp -Path $cmdletDocPaths -OutputPath $helpPath >$null
    }
}

task build {
    Write-Output "Build started: $(Get-Date -Format FileDateTime)"

    if ($Configuration -ne 'Debug') {
        $git = git status
        if ($git[1] -notmatch "Your branch is up to date") {
            throw "Local branch has commits not in GitHub"
        }

        if ([string]::IsNullOrEmpty($GalleryKey) -and ($Configuration -ne 'PreRelease')) {
            throw "Gallery Key must be provided to release"
        }

        if ((gh config get prompt) -eq 'enabled') {
            Invoke-Expression "gh config set prompt disabled"
        }

        if ($Configuration -eq 'Release' -or ($Configuration -eq 'PSGalleryRetry')) {
            $foundModule = Find-Module -Name $moduleName
            if ($foundModule.Version -ge $imported.Version) {
                throw "PowerShell Gallery version of $moduleName is more recent ($($foundModule.Version) >= $($imported.Version))"
            }

            try {
                Write-Output "Publishing $moduleName [$($imported.Version)] to PowerShell Gallery"
                Publish-Module -Path $moduleTempPath -NuGetApiKey $gallerykey
                Write-Output "Publishing to PS Gallery, completed"
            } catch {
                Write-Warning "Publishing to PS Gallery failed: $($_)"
            }
        }

        $tagName = "v$($moduleData.ModuleVersion)"
        $releaseTitle = "$moduleName $($moduleData.ModuleVersion)"
        if ($Configuration -eq 'PreRelease') {
            $tagName = "$tagName-$($GitHubPreTag)"
            $releaseTitle = "$releaseTitle-$($GitHubPreTag)"
        }
        Compress-Archive "$staging\$moduleName\*" -DestinationPath $zipFilePath -CompressionLevel Fastest -Force

        $ghArgs = "release create `"$tagName`" `"$($zipFilePath)#$($zipFileName)`" --title `"$releaseTitle`" --notes-file $changeLog"

        if ($Configuration -eq 'Prerelease') {
            $ghArgs = $ghArgs + " --prerelease"
        }

        if ($Configuration -ne 'PSGalleryRetry') {
            if (Test-Path $changeLog) {
                Write-Output "gh command to execute: $ghArgs"
                Invoke-Expression "gh $ghArgs"
            } else {
                throw "release.md file not found"
            }
        }

        if ((gh config get prompt) -eq 'disabled') {
            Invoke-Expression "gh config set prompt enabled"
        }

        if ($Configuration -eq 'Release' -and ($Configuration -ne 'PSGalleryRetry')) {
            try {
                $testAzAccount = az account list | ConvertFrom-Json
            } catch {
                throw "az CLI is not connected"
            }
            if ($testAzAccount) {
                # generate hash text file
                $hashFileName = "$($moduleName)_hash.txt"
                $hashFilePath = Join-Path $staging $hashFileName
                Get-FileHash -Algorithm SHA256 -Path $zipFilePath | Select-Object Algorithm, Hash | Out-File $hashFilePath -Force

                # module zip file
                $azArgs = 'storage blob upload --account-name thyproservices --container-name ''$web'' --name ' + $zipFileName + ' --file ' + $zipFilePath
                Write-Output "Azure CLI args: $azArgs"
                Invoke-Expression "az $azArgs"

                # module zip hash file
                $azArgs = 'storage blob upload --account-name thyproservices --container-name ''$web'' --name ' + $hashFileName + ' --file ' + $hashFilePath
                Write-Output "Azure CLI args: $azArgs"
                Invoke-Expression "az $azArgs"
            } else {
                Write-Output "No Azure Account"
            }
        }
    }
}

task . build