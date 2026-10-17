function Search-TssSecretEraseSecret {
    <#
    .SYNOPSIS
    Get the secrets of a secret erase request

    .DESCRIPTION
    Returns the secrets in a secret erase request and when each one was erased.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER RequestId
    Secret erase request ID

    .PARAMETER Erased
    Only secrets already erased; -Erased:$false returns the secrets not yet erased

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecretEraseSecret -TssSession $session -RequestId 17

    Returns the secrets in secret erase request 17

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretEraseRequest -TssSession $session -Id 17 | Search-TssSecretEraseSecret -TssSession $session -Erased

    Returns the secrets of request 17 that are already erased

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-erase-requests/Search-TssSecretEraseSecret

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-erase-requests/Search-TssSecretEraseSecret.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.EraseRequests.Secret[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('Id', 'SecretEraseRequestId')]
        [int]
        $RequestId,

        [switch]
        $Erased
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secret-erase-requests', 'secrets' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'RequestId' {
                    $queryParams += "filter.secretEraseRequestId=$($RequestId)"
                }
                'Erased' {
                    $queryParams += "filter.erased=$([boolean]$Erased)"
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
                Write-Warning 'Issue with Search-TssSecretEraseSecret request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.EraseRequests.Secret[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.EraseRequests.Secret]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
