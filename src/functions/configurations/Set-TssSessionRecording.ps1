function Set-TssSessionRecording {
    <#
    .SYNOPSIS
    Set the session recording configuration

    .DESCRIPTION
    Updates the session recording settings on the Configuration Session Recording tab. Only the parameters given are changed. Returns the updated configuration.
    Every setting other than EnableSessionRecording is saved only while session recording is enabled, already or by -EnableSessionRecording in the same call; otherwise Secret Server ignores it and returns the current settings. SSH and RDP proxy recording settings are saved only while that proxy is enabled.
    Secret Server rejects every change while launchers are disabled (Launcher must be enabled to import these settings).

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER ArchiveLocationBySite
    Archive to a separate location per site (ArchivePathMappings)

    .PARAMETER ArchivePath
    Folder session recordings are archived to

    .PARAMETER ArchivePathMappings
    Archive folder per site: objects with SiteId and Path properties, for example @{ SiteId = 1; Path = 'D:\Recordings\Site1' }

    .PARAMETER DaysUntilArchive
    Days after which session recordings are archived

    .PARAMETER DaysUntilDelete
    Days after which session recordings are deleted

    .PARAMETER EnableArchive
    Archive session recordings after DaysUntilArchive

    .PARAMETER EnableDelete
    Delete session recordings after DaysUntilDelete

    .PARAMETER EnableHardwareAcceleration
    Use hardware acceleration for video processing

    .PARAMETER EnableInactivityTimeout
    End recorded sessions after InactivityTimeoutMinutes without activity

    .PARAMETER EnableOnDemandVideoProcessing
    Process session videos only when they are requested

    .PARAMETER EnableSessionRecording
    Enable session recording; -EnableSessionRecording:$false disables it

    .PARAMETER EncryptArchive
    Encrypt archived session recordings

    .PARAMETER HideRecordingIndicator
    Hide the recording indicator during sessions

    .PARAMETER InactivityTimeoutMinutes
    Minutes without activity before a recorded session ends

    .PARAMETER MaxSessionLength
    Maximum recorded session length in hours

    .PARAMETER RdpProxyRecordKeyStrokes
    Record keystrokes of RDP proxy sessions

    .PARAMETER RdpProxyRecordVideo
    Record video of RDP proxy sessions

    .PARAMETER SshProxyRecordKeyStrokes
    Record keystrokes of SSH proxy sessions

    .PARAMETER SshProxyRecordVideo
    Record video of SSH proxy sessions

    .PARAMETER StoreInDatabase
    Store session recordings in the database

    .PARAMETER UseTemporaryArchives
    Use temporary archives while processing

    .PARAMETER VideoCodecId
    ID of the video codec used to encode session recordings

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSessionRecording -TssSession $session -EnableSessionRecording -MaxSessionLength 4

    Enable session recording and limit recorded sessions to 4 hours

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSessionRecording -TssSession $session -EnableArchive -ArchivePath D:\Recordings -DaysUntilArchive 30

    Archive session recordings to a share after 30 days

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssSessionRecording

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssSessionRecording.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Configuration.SessionRecording')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $ArchiveLocationBySite,

        [string]
        $ArchivePath,

        [object[]]
        $ArchivePathMappings,

        [int]
        $DaysUntilArchive,

        [int]
        $DaysUntilDelete,

        [switch]
        $EnableArchive,

        [switch]
        $EnableDelete,

        [switch]
        $EnableHardwareAcceleration,

        [switch]
        $EnableInactivityTimeout,

        [switch]
        $EnableOnDemandVideoProcessing,

        [switch]
        $EnableSessionRecording,

        [switch]
        $EncryptArchive,

        [switch]
        $HideRecordingIndicator,

        [int]
        $InactivityTimeoutMinutes,

        [int]
        $MaxSessionLength,

        [switch]
        $RdpProxyRecordKeyStrokes,

        [switch]
        $RdpProxyRecordVideo,

        [switch]
        $SshProxyRecordKeyStrokes,

        [switch]
        $SshProxyRecordVideo,

        [switch]
        $StoreInDatabase,

        [switch]
        $UseTemporaryArchives,

        [int]
        $VideoCodecId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'sessionrecording' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'ArchiveLocationBySite' {
                    $body.data.Add('archiveLocationBySite', @{ dirty = $true; value = [boolean]$ArchiveLocationBySite })
                }
                'ArchivePath' {
                    $body.data.Add('archivePath', @{ dirty = $true; value = $ArchivePath })
                }
                'ArchivePathMappings' {
                    $body.data.Add('archivePathMappings', @{ dirty = $true; value = $ArchivePathMappings })
                }
                'DaysUntilArchive' {
                    $body.data.Add('daysUntilArchive', @{ dirty = $true; value = $DaysUntilArchive })
                }
                'DaysUntilDelete' {
                    $body.data.Add('daysUntilDelete', @{ dirty = $true; value = $DaysUntilDelete })
                }
                'EnableArchive' {
                    $body.data.Add('enableArchive', @{ dirty = $true; value = [boolean]$EnableArchive })
                }
                'EnableDelete' {
                    $body.data.Add('enableDelete', @{ dirty = $true; value = [boolean]$EnableDelete })
                }
                'EnableHardwareAcceleration' {
                    $body.data.Add('enableHardwareAcceleration', @{ dirty = $true; value = [boolean]$EnableHardwareAcceleration })
                }
                'EnableInactivityTimeout' {
                    $body.data.Add('enableInactivityTimeout', @{ dirty = $true; value = [boolean]$EnableInactivityTimeout })
                }
                'EnableOnDemandVideoProcessing' {
                    $body.data.Add('enableOnDemandVideoProcessing', @{ dirty = $true; value = [boolean]$EnableOnDemandVideoProcessing })
                }
                'EnableSessionRecording' {
                    $body.data.Add('enableSessionRecording', @{ dirty = $true; value = [boolean]$EnableSessionRecording })
                }
                'EncryptArchive' {
                    $body.data.Add('encryptArchive', @{ dirty = $true; value = [boolean]$EncryptArchive })
                }
                'HideRecordingIndicator' {
                    $body.data.Add('hideRecordingIndicator', @{ dirty = $true; value = [boolean]$HideRecordingIndicator })
                }
                'InactivityTimeoutMinutes' {
                    $body.data.Add('inactivityTimeoutMinutes', @{ dirty = $true; value = $InactivityTimeoutMinutes })
                }
                'MaxSessionLength' {
                    $body.data.Add('maxSessionLength', @{ dirty = $true; value = $MaxSessionLength })
                }
                'RdpProxyRecordKeyStrokes' {
                    $body.data.Add('rdpProxyRecordKeyStrokes', @{ dirty = $true; value = [boolean]$RdpProxyRecordKeyStrokes })
                }
                'RdpProxyRecordVideo' {
                    $body.data.Add('rdpProxyRecordVideo', @{ dirty = $true; value = [boolean]$RdpProxyRecordVideo })
                }
                'SshProxyRecordKeyStrokes' {
                    $body.data.Add('sshProxyRecordKeyStrokes', @{ dirty = $true; value = [boolean]$SshProxyRecordKeyStrokes })
                }
                'SshProxyRecordVideo' {
                    $body.data.Add('sshProxyRecordVideo', @{ dirty = $true; value = [boolean]$SshProxyRecordVideo })
                }
                'StoreInDatabase' {
                    $body.data.Add('storeInDatabase', @{ dirty = $true; value = [boolean]$StoreInDatabase })
                }
                'UseTemporaryArchives' {
                    $body.data.Add('useTemporaryArchives', @{ dirty = $true; value = [boolean]$UseTemporaryArchives })
                }
                'VideoCodecId' {
                    $body.data.Add('videoCodecId', @{ dirty = $true; value = $VideoCodecId })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Session recording", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssSessionRecording request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Configuration.SessionRecording](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.SessionRecording]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
