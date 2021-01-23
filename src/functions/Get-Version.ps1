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
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> Get-TssVersion -TssSession $session

    Returns version of Secret Server alpha

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
        [TssSession]$TssSession,

        # output the raw response from the API endpoint
        [switch]
        $Raw
    )
    begin {
        $tssParams = $PSBoundParameters
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $TssVersionObject -TssSession $TssSession -Invocation $PSCmdlet.MyInvocation -Raw:$Raw
        } else {
            Write-Warning "No valid session found"
        }
    }
}