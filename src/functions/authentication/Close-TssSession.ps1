function Close-TssSession {
    <#
    .SYNOPSIS
    Expire the current session to Secret Server

    .DESCRIPTION
    Expire the current session to Secret Server

    A Delinea Platform session (New-TssSession -PlatformUrl) is not expired: Secret Server does not govern Platform tokens, so the token stays valid until it expires at the Platform and False is returned.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Close-TssSession -TssSession $session

    Close the session, expiring the access token were it is no longer usable

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/authentication/Close-TssSession

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/authentication/Close-TssSession.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('System.Boolean')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession
    )
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        switch ($TssSession.TokenType) {
            'WindowsAuth' { Write-Warning "Not supported token type for closing" }
            'SdkClient' { Write-Warning "Not supported token type for closing" }
            'Platform' {
                Write-Verbose 'Delinea Platform token: Secret Server oauth-expiration does not apply, the token stays valid until it expires at the Platform'
                $TssSession.SessionExpire()
            }
            default { $TssSession.SessionExpire() }
        }
    }
}