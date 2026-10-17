function Get-TssCurrentUserSummary {
    <#
    .SYNOPSIS
    Get the user ID of the current user

    .DESCRIPTION
    Returns a summary of the user who owns the session.
    The summary carries only the user ID; Show-TssCurrentUser returns the full profile.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssCurrentUserSummary -TssSession $session

    Returns the user ID of the current user

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Get-TssCurrentUserSummary

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Get-TssCurrentUserSummary.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Users.CurrentUserSummary')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'users', 'current-summary' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssCurrentUserSummary request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Users.CurrentUserSummary](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Users.CurrentUserSummary]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
