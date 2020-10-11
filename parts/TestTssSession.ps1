<#
.Synopsis
    Validates token in $SecSrvSession is still valid
.Description
    Test to ensure token is still valid, if expired can use refresh token, or reconnect
#>
param(
    # Validate the TssSession object has minimal values
    # SecretServerUrl, AccessToken
    [switch]
    $Session,

    # Validate just token use for session
    [switch]
    $Token,

    # Validate refresh token use for session
    [switch]
    $Refresh
)

if ($Session) {
    if (-not $TssSession.SecretServerUrl) {
        throw 'Secret Server URL not found'
    }
    if ([string]::IsNullOrEmpty($TssSession.AccessToken) -and [string]::IsNullOrEmpty($TssSession.RefreshToken) -and (-not [string]::IsNullOrEmpty($TssSession.StartTime)) ) {
        throw "No valid token found for your current session"
    }
}

if ($Token) {
    if ($TssSession.AccessToken) {
        if ([datetime]::UtcNow -lt $TssSession.TimeOfDeath) {
            Write-Verbose -Message "Session within TimeOfDeath"
            # throw ""
        }
        if ([datetime]::UtcNow -gt $TssSession.TimeOfDeath) {
            Write-Verbose -Message "Session TimeOfDeath exceeded"
            # return $false
        }
    }
}
if ($Refresh) {
    if ($TssSession.TimeOfDeath -lt [datetime]::UtcNow -and $TssSession.RefreshCount -le 0) {
        throw "Use of Refresh Token not supported with current Session (see Get-TssSession output)"
    }
    if ($TssSession.TimeOfDeath -lt [datetime]::UtcNow -and $TssSession.RefreshCount -gt 0) {
        Write-Warning -Message "TimeOfDeath not exceeded but continuing to use RefreshToken"
    }
    if ($TssSession.RefreshCount -gt 0 -and ([datetime]::UtcNow -gt $TssSession.TimeOfDeath)) {
        Write-Verbose "Session exceeded TimeOfDeath, RefreshToken count > 0"
        return $true
    }
    if ($TssSession.RefreshCount -le 0 -and ([datetime]::UtcNow -gt $TssSession.TimeOfDeath)) {
        Write-Verbose "Session exceeded TimeOfDeath AND RefreshCount exceeded"
        return $false
    }
}
