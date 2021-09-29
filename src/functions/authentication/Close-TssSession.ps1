function Close-TssSession {
    <#
    .SYNOPSIS
    Expire the current session to Secret Server

    .DESCRIPTION
    Expire the current session to Secret Server

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
            default { $TssSession.SessionExpire() }
        }
    }
}