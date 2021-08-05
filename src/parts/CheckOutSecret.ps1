<#
    .Synopsis
        Checkout a secret
    .Description
        Certain endpoints are found to not support restricted arguments
        When that happens the secret has to be checked out before the given endpoint can be used
        This part is used to perform that checkout using restricted params of the function
        Endpoints used:
            - POST /secret-access-requests/secrets/{id}/view-comment
            - POST /secrets/{id}/check-out
#>
[cmdletbinding(SupportsShouldProcess)]
param(
    [Parameter(ValueFromPipeline,Position = 0,Mandatory)]
    [Thycotic.PowerShell.Authentication.Session]
    $TssSession,

    [Parameter(ValueFromPipeline,Position = 1,Mandatory)]
    [Collections.IDictionary]
    $FunctionParameters,

    [Parameter(ValueFromPipeline,Position = 2,Mandatory)]
    [int]
    $SecretId
)

begin {
    $invokeViewCommentParams = . $GetInvokeTssParams $TssSession
    $invokeCheckOutParams = . $GetInvokeTssParams $TssSession
}

process {
    $restrictedBody = @{}
    if ($FunctionParameters.ContainsKey('Comment')) {
        $restrictedBody.Add('comment', $FunctionParameters['Comment'])
    }
    if ($FunctionParameters.ContainsKey('TicketNumber')) {
        $restrictedBody.Add('ticketNumber', $FunctionParameters['TicketNumber'])
    }
    if ($FunctionParameters.ContainsKey('TicketSystemId')) {
        $restrictedBody.Add('ticketSystemId', $FunctionParameters['TicketSystemId'])
    }

    if ($restrictedBody.Count -gt 0) {
        # secret view comment
        $uri = $TssSession.ApiUrl, 'secret-access-requests', 'secrets', $SecretId, 'view-comment' -join '/'

        $invokeViewCommentParams.Body = $restrictedBody | ConvertTo-Json
        $invokeViewCommentParams.Uri = $uri
        $invokeViewCommentParams.Method = 'POST'

        if ($PSCmdlet.ShouldProcess("SecretId: $SecretId", "$($invokeViewCommentParams.Method) $uri with: `n$($invokeViewCommentParams.Body)`n")) {
            Write-Verbose "$($invokeViewCommentParams.Method) $uri with:`n$($invokeViewCommentParams.Body)`n"
            try {
                $apiResponse = Invoke-TssApi @invokeViewCommentParams
                . $ProcessResponse $apiResponse >$null
            } catch {
                Write-Warning "Issue doing pre-checkout of Secret [$SecretId]"
                $err = $_
                . $ErrorHandling $err
            }
        }
    }

    # secret check-out
    $uri = $TssSession.ApiUrl, 'secrets', $SecretId, 'check-out' -join '/'
    $invokeCheckOutParams.Uri = $uri
    $invokeCheckOutParams.Method = 'POST'
    if ($PSCmdlet.ShouldProcess("SecretId: $SecretId", "$($invokeCheckOutParams.Method) $uri")) {
        Write-Verbose "$($invokeCheckOutParams.Method) $uri"
        try {
            $apiResponse = Invoke-TssApi @invokeCheckOutParams
            $checkOutResponse = . $ProcessResponse $apiResponse
        } catch {
            Write-Warning "Issue doing pre-checkout of Secret [$SecretId]"
            $err = $_
            . $ErrorHandling $err
        }

        if ($checkOutResponse) {
            Write-Verbose "Secret [$secretId] checked out successfully"
        }
    }
}