[cmdletbinding()]
param(
    [Parameter(ParameterSetName = 'docs')]
    [switch]
    $PublishDocs,

    [Parameter(ParameterSetName = 'publish')]
    [string]
    $GalleryKey,

    [Parameter(ParameterSetName = 'publish')]
    [switch]
    $Prerelease,

    [Parameter(ParameterSetName = 'release')]
    [Parameter(ParameterSetName = 'publish')]
    [switch]
    $Release,

    [Parameter(ParameterSetName = 'release')]
    [Parameter(ParameterSetName = 'publish')]
    [switch]
    $Draft,

    [Parameter(ParameterSetName = 'publish')]
    [switch]
    $SkipTests
)
Push-Location
Set-Location $PSScriptRoot
$moduleName = 'Thycotic.SecretServer'
$staging = "$env:TEMP\tss_staging\"

$git = git status
if ($git[1] -notmatch "Your branch is up to date" -and (-not $PSBoundParameters.ContainsKey('PublishDocs'))) {
    Pop-Location
    throw "Local branch has commits not in GitHub"
}
if (Test-Path $staging) {
    Remove-Item -Recurse -Force $staging
}
if (Get-Module Thycotic.SecretServer) {
    Remove-Module Thycotic.SecretServer -Force
}
$imported = Import-Module "$PSScriptRoot\src\Thycotic.SecretServer.psd1" -Force -PassThru

if ($PSBoundParameters['PublishDocs']) {
    if ($PSEdition -eq 'Desktop') {
        Write-Warning "Doc processing has to run under PowerShell Core"
        return
    }
    $docRoot = "$PSScriptRoot\docs\commands"
    $functionsRoot = "$PSScriptRoot\src\functions"
    $functionDirectories = [IO.Directory]::GetDirectories($functionsRoot)

    Import-Module platyPS
    $cmdParams = @{
        Module      = $moduleName
        CommandType = 'Function'
    }
    $commands = Get-Command @cmdParams

    $functionDirectories.foreach({
            $categoryFolderName = Split-Path $_ -Leaf
            $docCommandPath = [IO.Path]::Combine($docRoot,$categoryFolderName)

            if (Test-Path $docCommandPath) {
                $helpNames = Get-ChildItem $_ -File | ForEach-Object { $_.BaseName -replace '-','-Tss' }
                $helpCommands = $commands.Where({ $_.Name -in $helpNames })
                $helpCommands.foreach({
                        New-MarkdownHelp -OutputFolder $docCommandPath -Command $_.Name -NoMetadata -Force
                    })
            } else {
                Write-Error "Doc path does not exist: $docCommandPath"
            }
        })
    return
}

if (-not $PSBoundParameters['SkipTests']) {
    Import-Module Pester
    $tests = Invoke-Pester -Path "$PSScriptRoot\tests" -Output Minimal -PassThru
}

if ($PSBoundParameters['Prerelease']) {
    $foundModule = Find-Module -Name $moduleName -AllowPrerelease:$Prerelease
} else {
    $foundModule = Find-Module -Name $moduleName
}

if ($foundModule.Version -ge $imported.Version) {
    Write-Warning "PowerShell Gallery version of $moduleName is more recent ($($foundModule.Version) >= $($imported.Version))"
}

if ($tests.FailedCount -eq 0 -or $PSBoundParameters['SkipTests']) {
    $moduleTempPath = Join-Path $staging $moduleName
    Write-Host "Staging directory: $moduleTempPath"
    $imported | Split-Path | Copy-Item -Destination $moduleTempPath -Recurse

    if ($PSBoundParameters['GalleryKey']) {
        try {
            Write-Host "Publishing $moduleName [$($imported.Version)] to PowerShell Gallery"

            Publish-Module -Path $moduleTempPath -NuGetApiKey $gallerykey
            Write-Host "successfully published to PS Gallery"
        } catch {
            Write-Warning "Publish failed: $_"
        }
    }
    if ($PSBoundParameters['Release']) {
        $zipFilePath = Join-Path $staging "$moduleName.zip"
        $zipFileName = "$($moduleName).zip"

        if ((gh config get prompt) -eq 'enabled') {
            Invoke-Expression "gh config set prompt disabled"
        }
        $moduleData = Import-PowerShellDataFile "$staging\$moduleName\$moduleName.psd1"
        $changeLog = [IO.Path]::Combine([string]$PSScriptRoot, 'release.md')
        Compress-Archive "$staging\$moduleName\*" -DestinationPath $zipFilePath -CompressionLevel Fastest -Force
        $ghArgs = "release create `"v$($moduleData.ModuleVersion)`" `"$($zipFilePath)#$($zipFileName)`" --title `"$moduleName $($moduleData.ModuleVersion)`" --notes-file $changeLog"
        if ($PSBoundParameters['Prerelease']) {
            $ghArgs = $ghArgs + " --prerelease"
        }
        if ($PSBoundParameters['Draft']) {
            $ghArgs = $ghArgs + " --draft"
        }

        Write-Host "gh command to execute: $ghArgs" -ForegroundColor DarkYellow

        Invoke-Expression "gh $ghArgs"

        if ((gh config get prompt) -eq 'disabled') {
            Invoke-Expression "gh config set prompt enabled"
        }

        # generate hash text file
        $hashFileName = "$($moduleName)_hash.txt"
        $hashFilePath = Join-Path $staging $hashFileName
        Get-FileHash -Algorithm SHA256 -Path $zipFilePath | Select-Object Algorithm, Hash | Out-File $hashFilePath -Force

        # module zip file
        $azArgs = 'storage blob upload --account-name thyproservices --container-name ''$web'' --name ' + $zipFileName + ' --file ' + $zipFilePath
        Write-Host "Azure CLI args: $azArgs" -ForegroundColor DarkBlue
        Invoke-Expression "az $azArgs"

        # module zip hash file
        $azArgs = 'storage blob upload --account-name thyproservices --container-name ''$web'' --name ' + $hashFileName + ' --file ' + $hashFilePath
        Write-Host "Azure CLI args: $azArgs" -ForegroundColor DarkYellow
        Invoke-Expression "az $azArgs"
    }

} else {
    Remove-Item -Recurse -Force $staging
    Write-Host "Tests failures detected; cancelling and cleaning up"
}
Pop-Location