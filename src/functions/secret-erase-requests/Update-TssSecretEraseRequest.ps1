function Update-TssSecretEraseRequest {
    <#
    .SYNOPSIS
    Approve, deny, cancel or reschedule a secret erase request

    .DESCRIPTION
    Updates a secret erase request. Approvers set Status to Approved or Denied; the requester can set Canceled. -EraseAfter moves the erase date.
    Requires the Secret Erase feature.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret erase request ID

    .PARAMETER Status
    New status: approvers set Approved or Denied, the requester sets Canceled

    .PARAMETER EraseAfter
    New date after which the secrets are erased

    .PARAMETER Comment
    Comment recorded with the response

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssSecretEraseRequest -TssSession $session -Id 17 -Status Approved -Comment 'Approved by security'

    Approves secret erase request 17

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretEraseRequestInbox -TssSession $session -Status Pending -IsMyRequest | Update-TssSecretEraseRequest -TssSession $session -Status Canceled

    Cancels all of your pending secret erase requests

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-erase-requests/Update-TssSecretEraseRequest

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-erase-requests/Update-TssSecretEraseRequest.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.EraseRequests.ActionResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretEraseRequestId')]
        [int]
        $Id,

        [Parameter(Mandatory)]
        [ValidateSet('Pending', 'Approved', 'Denied', 'Canceled', 'Completed', 'CompletedWithErrors')]
        [string]
        $Status,

        [datetime]
        $EraseAfter,

        [Alias('ResponseComment')]
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
            $invokeParams.Method = 'PUT'
            $body = @{ }
            switch ($tssParams.Keys) {
                'Id' {
                    $body.Add('secretEraseRequestId', $Id)
                }
                'Status' {
                    $body.Add('status', $Status)
                }
                'EraseAfter' {
                    $body.Add('eraseAfter', $EraseAfter.ToUniversalTime().ToString('o'))
                }
                'Comment' {
                    $body.Add('responseComment', $Comment)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Secret erase request", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssSecretEraseRequest request'
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
