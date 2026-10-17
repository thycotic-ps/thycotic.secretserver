function Get-TssSessionImage {
    <#
    .SYNOPSIS
    Save a captured screen image of a recorded session

    .DESCRIPTION
    Downloads a captured screen image of a recorded session to a folder and returns the saved file.
    Identify the session by secret session ID, secret session key or launcher session GUID. Without ImageId the latest image is saved; Get-TssSessionFrame lists the image IDs.
    The file is named session-image-<session>-<ImageId or latest> with the extension of the image type.
    Secret Server returns an error for a session with no captured images.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER SecretSessionId
    Secret session ID (SecretSessionId in Search-TssRecordedSession output)

    .PARAMETER SecretSessionKey
    Secret session key

    .PARAMETER LauncherSessionGuid
    Launcher session GUID (LauncherSessionGuid in Search-TssRecordedSession output)

    .PARAMETER ImageId
    Image ID (ImageId in Get-TssSessionFrame output); omit for the latest image

    .PARAMETER Output
    Folder to save the file in

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSessionImage -TssSession $session -SecretSessionId 786 -Output .\images

    Saves the latest captured image of secret session 786 to the images folder

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSessionFrame -TssSession $session -SecretSessionId 786 | Get-TssSessionImage -TssSession $session -SecretSessionId 786 -Output .\images

    Saves every captured image of secret session 786

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSessionImage -TssSession $session -LauncherSessionGuid 0d1e5c8a-6f3b-4c2e-9a7d-3b2f1e4c5d6a -ImageId 12 -Output .\images

    Saves image 12 of the session with launcher session GUID 0d1e5c8a-6f3b-4c2e-9a7d-3b2f1e4c5d6a

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Get-TssSessionImage

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Get-TssSessionImage.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'id')]
    [OutputType('System.IO.FileInfo')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'id')]
        [int]
        $SecretSessionId,

        [Parameter(Mandatory, ParameterSetName = 'key')]
        [string]
        $SecretSessionKey,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'guid')]
        [guid]
        $LauncherSessionGuid,

        [Parameter(ValueFromPipelineByPropertyName)]
        [int]
        $ImageId,

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
            $apiResponse = $null
            switch ($PSCmdlet.ParameterSetName) {
                'id' {
                    $uri = $TssSession.ApiUrl, 'recorded-sessions', 'session-image', $SecretSessionId -join '/'
                    $sessionLabel = $SecretSessionId
                }
                'key' {
                    $uri = $TssSession.ApiUrl, 'recorded-sessions', 'session-image-by-key', [uri]::EscapeDataString($SecretSessionKey) -join '/'
                    $sessionLabel = $SecretSessionKey -replace '[^A-Za-z0-9-]', '_'
                }
                'guid' {
                    $uri = $TssSession.ApiUrl, 'recorded-sessions', 'session-image-by-launcher-guid', $LauncherSessionGuid -join '/'
                    $sessionLabel = $LauncherSessionGuid
                }
            }
            $imageLabel = 'latest'
            if ($tssParams.ContainsKey('ImageId')) {
                $uri = $uri, $ImageId -join '/'
                $imageLabel = $ImageId
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $null = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue downloading the session image of [$sessionLabel]"
                $err = $_
                . $ErrorHandling $err
            }
            if ($apiResponse.IsSuccessful -and $apiResponse.RawBytes) {
                $extension = if ($apiResponse.ContentType) { (([string]$apiResponse.ContentType -split '[/;]')[1]) -replace '^jpeg$', 'jpg' } else { 'bin' }
                $filePath = [IO.Path]::Combine($outputFolder, "session-image-$sessionLabel-$imageLabel.$extension")
                [IO.File]::WriteAllBytes($filePath, $apiResponse.RawBytes)
                Get-Item -LiteralPath $filePath
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
