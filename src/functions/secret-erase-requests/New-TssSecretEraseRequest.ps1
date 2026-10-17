function New-TssSecretEraseRequest {
    <#
    .SYNOPSIS
    Create a secret erase request

    .DESCRIPTION
    Requests that the given secrets be permanently erased after the EraseAfter date.
    The request goes through erase approval; approvers approve or deny it with Update-TssSecretEraseRequest.
    Requires the Secret Erase feature.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER SecretId
    Secret IDs to erase

    .PARAMETER EraseAfter
    Date after which the secrets are erased

    .PARAMETER Comment
    Reason for the request

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssSecretEraseRequest -TssSession $session -SecretId 42, 43 -EraseAfter (Get-Date).AddDays(7) -Comment 'Decommissioned servers'

    Requests that secrets 42 and 43 be erased in 7 days

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-erase-requests/New-TssSecretEraseRequest

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-erase-requests/New-TssSecretEraseRequest.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.EraseRequests.ActionResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [Alias('SecretIds')]
        [int[]]
        $SecretId,

        [Parameter(Mandatory)]
        [datetime]
        $EraseAfter,

        [Alias('RequestComment')]
        [string]
        $Comment
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secret-erase-requests' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ }
            switch ($tssParams.Keys) {
                'SecretId' {
                    $body.Add('secretIds', $SecretId)
                }
                'EraseAfter' {
                    $body.Add('eraseAfter', $EraseAfter.ToUniversalTime().ToString('o'))
                }
                'Comment' {
                    $body.Add('requestComment', $Comment)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Secret erase request", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssSecretEraseRequest request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.EraseRequests.ActionResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.EraseRequests.ActionResult]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
