function Get-TssRecordedSessionInstaller {
    <#
    .SYNOPSIS
    Save the Advanced Session Recording Agent installer

    .DESCRIPTION
    Downloads the Advanced Session Recording Agent (ASRA) installer zip of one or more launcher agent collections to a folder and returns the saved files.
    The file name is the one Secret Server returns; when none is returned the file is named asra-installer-<Id>.zip.
    The installer is large, so each download waits up to one hour.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Launcher agent collection ID (not a recorded session ID)

    .PARAMETER Output
    Folder to save the files in

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssRecordedSessionInstaller -TssSession $session -Id 1 -Output .\installers

    Saves the session recording agent installer of launcher agent collection 1 to the installers folder

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Get-TssRecordedSessionInstaller

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Get-TssRecordedSessionInstaller.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('System.IO.FileInfo')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('LauncherAgentCollectionId')]
        [int[]]
        $Id,

        [Parameter(Mandatory)]
        [ValidateScript( { Test-Path $_ -PathType Container })]
        [string]
        $Output
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
        $invokeParams.Timeout = [int][timespan]::FromHours(1).TotalMilliseconds
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $outputFolder = (Resolve-Path -Path $Output).ProviderPath
            foreach ($currentId in $Id) {
                $apiResponse = $null
                $uri = $TssSession.ApiUrl, 'recorded-sessions', 'download-installer', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $null = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue downloading the session recording agent installer [$currentId]"
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($apiResponse.IsSuccessful -and $apiResponse.RawBytes) {
                    $fileName = $null
                    $disposition = (@($apiResponse.ContentHeaders) | Where-Object { $_.Name -eq 'Content-Disposition' } | Select-Object -First 1).Value
                    $parsedDisposition = $null
                    if ($disposition -and [System.Net.Http.Headers.ContentDispositionHeaderValue]::TryParse([string]$disposition, [ref]$parsedDisposition) -and $parsedDisposition.FileName) {
                        $fileName = [IO.Path]::GetFileName($parsedDisposition.FileName.Trim('"'))
                    }
                    if (-not $fileName) {
                        $fileName = "asra-installer-$currentId.zip"
                    }
                    $filePath = [IO.Path]::Combine($outputFolder, $fileName)
                    [IO.File]::WriteAllBytes($filePath, $apiResponse.RawBytes)
                    Get-Item -LiteralPath $filePath
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
