function Get-TssRecordedSessionRecording {
    <#
    .SYNOPSIS
    Save the video of a recorded session

    .DESCRIPTION
    Downloads the video of one or more recorded sessions to a folder and returns the saved files.
    The file name is the one Secret Server returns for the video; when none is returned the file is named recorded-session-<Id> with the extension of the video type.
    A session with no processed video saves no file and writes a warning; Invoke-TssRecordedSessionRequestProcessing asks Secret Server to process it.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Recorded session ID: the launcher session GUID (LauncherSessionGuid in Search-TssRecordedSession output)

    .PARAMETER Output
    Folder to save the files in

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssRecordedSessionRecording -TssSession $session -Id 0d1e5c8a-6f3b-4c2e-9a7d-3b2f1e4c5d6a -Output .\recordings

    Saves the video of recorded session 0d1e5c8a-6f3b-4c2e-9a7d-3b2f1e4c5d6a to the recordings folder

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssRecordedSession -TssSession $session -SecretIds 42 -DateRange 7 | Get-TssRecordedSessionRecording -TssSession $session -Output .\recordings

    Saves the videos of the sessions of secret 42 from the last 7 days

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Get-TssRecordedSessionRecording

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Get-TssRecordedSessionRecording.ps1

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
        [Alias('LauncherSessionGuid')]
        [guid[]]
        $Id,

        [Parameter(Mandatory)]
        [ValidateScript( { Test-Path $_ -PathType Container })]
        [string]
        $Output
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $outputFolder = (Resolve-Path -Path $Output).ProviderPath
            foreach ($currentId in $Id) {
                $apiResponse = $null
                $uri = $TssSession.ApiUrl, 'recorded-sessions', $currentId, 'session-recordings' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $null = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue downloading the video of recorded session [$currentId]"
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
                        $extension = if ($apiResponse.ContentType) { ([string]$apiResponse.ContentType -split '[/;]')[1] } else { 'bin' }
                        $fileName = "recorded-session-$currentId.$extension"
                    }
                    $filePath = [IO.Path]::Combine($outputFolder, $fileName)
                    [IO.File]::WriteAllBytes($filePath, $apiResponse.RawBytes)
                    Get-Item -LiteralPath $filePath
                } elseif ($apiResponse.IsSuccessful) {
                    Write-Warning "No video is available for recorded session [$currentId]"
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
