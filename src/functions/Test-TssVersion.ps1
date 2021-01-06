function Test-TssVersion {
    <#
    .SYNOPSIS
    Test Secret Server version

    .DESCRIPTION
    Tests whether Secret Server version returned by Get-TssVersion is the latest

    .EXAMPLE
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> Test-TssVersion -TssSession $session

    Pulls version of Secret Server and queries for latest version, returning object with details

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
        [TssSession]$TssSession
    )
    begin {
        $tssParams = . $GetParams $PSBoundParameters 'Get-TssVersion'
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.Contains('TssSession') -and $TssSession.IsValidSession()) {
            . $GetTssVersionObject -TssSession $TssSession -Invocation $PSCmdlet.MyInvocation
        } else {
            Write-Warning "No valid session found"
        }
    }
}