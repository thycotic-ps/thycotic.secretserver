<#
.Synopsis
    Validates token in $SecSrvSession is still valid
.Description
    Test to ensure token is still valid, if expired can use refresh token, or reconnect
#>
[cmdletbinding()]
param(
    # Validate just token use for session
    [switch]
    $Token,

    # Validate refresh token use for session
    [switch]
    $Refresh
)

if (-not $TssSession.SecretServerHost -and (-not $TssSession.AuthToken)) {
    Write-Warning "No Session details found. Please use New-TssSession to create a new session."
    $false
}

if ($Token) {
    if ($TssSession.AuthToken -and ($TssSession.AutoConnect -eq $false)) {
        if ([datetime]::UtcNow -lt $TssSession.TimeOfDeath) {
            Write-Verbose "Session within TimeOfDeath"
            return $true
        }
        if ([datetime]::UtcNow -gt $TssSession.TimeOfDeath) {
            Write-Verbose "Session TimeOfDeath exceeded"
            return $false
        }
    }
}
if ($Refresh) {
    if ($TssSession.RefreshCount -gt 0 -and ([datetime]::UtcNow -gt $TssSession.TimeOfDeath)) {
        Write-Verbose "Session exceeded TimeOfDeath, RefreshToken count > 0"
        return $true
    }
    if ($TssSession.RefreshCount -le 0 -and ([datetime]::UtcNow -gt $TssSession.TimeOfDeath)) {
        Write-Verbose "Session exceeded TimeOfDeath AND RefreshCount exceeded"
        return $false
    }
}

$false