function Get-TssDashboardLoggedIn {
    <#
    .SYNOPSIS
    Check whether the session is still logged in

    .DESCRIPTION
    Returns True when the access token of the session is still accepted as a logged-in user. The web UI calls the same endpoint to detect a session timeout.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDashboardLoggedIn -TssSession $session

    Check that the session token is still logged in

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/dashboard-services/Get-TssDashboardLoggedIn

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dashboard-services/Get-TssDashboardLoggedIn.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('System.Boolean')]
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
            $uri = $TssSession.ApiUrl, 'dashboard-services', 'logged-in' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssDashboardLoggedIn request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($null -ne $restResponse) {
                [System.Convert]::ToBoolean($restResponse)
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
