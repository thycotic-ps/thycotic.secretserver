function Get-TssSecretEraseRequestInbox {
    <#
    .SYNOPSIS
    Get the secret erase requests in your inbox

    .DESCRIPTION
    Returns the secret erase requests in the inbox of the current user with the given status, for example the requests waiting for your approval.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Status
    Status of the requests to return

    .PARAMETER IsMyRequest
    Only requests you created

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretEraseRequestInbox -TssSession $session -Status Pending

    Returns the pending secret erase requests in your inbox

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-erase-requests/Get-TssSecretEraseRequestInbox

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-erase-requests/Get-TssSecretEraseRequestInbox.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.EraseRequests.Request[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [ValidateSet('Pending', 'Approved', 'Denied', 'Canceled', 'Completed', 'CompletedWithErrors')]
        [string]
        $Status,

        [switch]
        $IsMyRequest
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secret-erase-requests', 'inbox' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'Status' {
                    $queryParams += "filter.status=$([uri]::EscapeDataString($Status))"
                }
                'IsMyRequest' {
                    $queryParams += "filter.isMyRequest=$([boolean]$IsMyRequest)"
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
                Write-Warning 'Issue with Get-TssSecretEraseRequestInbox request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.EraseRequests.Request[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.EraseRequests.Request]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
