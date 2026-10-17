function Search-TssSecretEraseRequest {
    <#
    .SYNOPSIS
    Search secret erase requests

    .DESCRIPTION
    Returns the secret erase requests visible to the current user, filtered by status, by secret or to the requests you created.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Status
    Only requests with this status

    .PARAMETER SecretId
    Only requests that include this secret ID

    .PARAMETER IsMyRequest
    Only requests you created

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecretEraseRequest -TssSession $session -Status Pending

    Returns the pending secret erase requests

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecretEraseRequest -TssSession $session -SecretId 42 -IsMyRequest

    Returns your secret erase requests that include secret 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-erase-requests/Search-TssSecretEraseRequest

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-erase-requests/Search-TssSecretEraseRequest.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.EraseRequests.Request[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [ValidateSet('Pending', 'Approved', 'Denied', 'Canceled', 'Completed', 'CompletedWithErrors')]
        [string]
        $Status,

        [int]
        $SecretId,

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
            $uri = $TssSession.ApiUrl, 'secret-erase-requests', 'search' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'Status' {
                    $queryParams += "filter.status=$([uri]::EscapeDataString($Status))"
                }
                'SecretId' {
                    $queryParams += "filter.secretId=$($SecretId)"
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
                Write-Warning 'Issue with Search-TssSecretEraseRequest request'
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
