function Test-Version {
    <#
    .SYNOPSIS
    Test Secret Server version

    .DESCRIPTION
    Tests whether Secret Server version returned by Get-TssVersion is the latest

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Test-TssVersion -TssSession $session

    Pulls version of Secret Server and queries for latest version, returning object with details

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/version/Test-TssVersion

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/version/Test-Version.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssVersion')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,
            ValueFromPipeline,
            Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]$TssSession
    )
    begin {
        $tssParams = $PSBoundParameters
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $TssVersionObject -TssSession $TssSession -Invocation $PSCmdlet.MyInvocation
        } else {
            Write-Warning 'No valid session found'
        }
    }
}