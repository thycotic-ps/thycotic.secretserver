function Get-Version {
    <#
    .SYNOPSIS
    Get version of Secret Server

    .DESCRIPTION
    Get the version of Secret Server

    .PARAMETER TssSession
    TssSession object created by New-TssSession

    .PARAMETER Raw
    Output the raw response from the REST API endpoint

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssVersion -TssSession $session

    Returns version of Secret Server alpha

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssVersion

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding()]
    [OutputType('TssVersion')]
    param(
        # TssSession object passed for auth info
        [Parameter(Mandatory,
            ValueFromPipeline,
            Position = 0)]
        [TssSession]$TssSession
    )
    begin {
        $tssParams = $PSBoundParameters
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $TssVersionObject -TssSession $TssSession -Invocation $PSCmdlet.MyInvocation
        } else {
            Write-Warning "No valid session found"
        }
    }
}