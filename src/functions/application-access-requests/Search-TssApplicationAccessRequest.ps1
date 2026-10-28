function Search-TssApplicationAccessRequest {
    <#
    .SYNOPSIS
    Search application access requests by status

    .DESCRIPTION
    Application access requests are created by Privilege Manager when an application on a managed device asks for access through Secret Server.
    Returns the requests visible to the current user, optionally filtered by status.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Status
    Only return requests with this status: Approved, Pending or Denied

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssApplicationAccessRequest -TssSession $session -Status Pending

    List the pending application access requests

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/application-access-requests/Search-TssApplicationAccessRequest

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/application-access-requests/Search-TssApplicationAccessRequest.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.ApplicationAccessRequests.Request[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [ValidateSet('Approved', 'Pending', 'Denied')]
        [string]
        $Status
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'application-access-requests' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'Status' {
                    $queryParams += "filter.status=$([uri]::EscapeDataString($Status))"
                }
            }
            if ($queryParams) {
                $uri = $uri, ($queryParams -join '&') -join '?'
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssApplicationAccessRequest request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.ApplicationAccessRequests.Request[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.ApplicationAccessRequests.Request]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
