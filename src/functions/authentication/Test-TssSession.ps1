function Test-TssSession {
    <#
    .SYNOPSIS
    Test TssSession object

    .DESCRIPTION
    Test TssSession object

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Test-TssSession -TssSession $session -Session

    Test that the session is Valid

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Test-TssSession -TssSession $session -Ttl 5

    Test if TimeOfDeath for the session is less than or equal 5 minutes, returns false if it is, otherwise true

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Test-TssSession -TssSession $session -Token

    Verifies the token is valid

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/authentication/Test-TssSession

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/authentication/Test-TssSession.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Test for a valid Session object, verifies following:
        #    AccessToken has a value
        #    StartTime property is set on the object
        #    If TokenType is SdkClient or WindowsAuth will always return true
        [switch]
        $Session,

        # Test for a valid token, verifies following:
        #    AccessToken has a value
        #    TimeOfDeath is greater than current time
        #    If TokenType is SdkClient, Windows Auth, or ExternalToken will always return true
        [switch]
        $Token,

        # Check token TTL (time-to-live), provide value in minutes
        #    Returns true if TotalMinutes <= (Get-Date).AddMinutes(<Ttl value>), else false.
        [int]
        $Ttl
    )
    begin {
        $tssParams = $PSBoundParameters
    }
    process {
        if ($tssParams.ContainsKey('Session')) {
            $TssSession.IsValidSession()
        }
        if ($tssParams.ContainsKey('Token')) {
            $TssSession.IsValidToken()
        }
        if ($tssParams.ContainsKey('Ttl')) {
            $TssSession.CheckTokenTtl($Ttl)
        }
    }
}