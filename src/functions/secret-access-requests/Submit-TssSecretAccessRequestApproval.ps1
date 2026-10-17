function Submit-TssSecretAccessRequestApproval {
    <#
    .SYNOPSIS
    Submit an approval decision for a secret access request by approval ID

    .DESCRIPTION
    Approves or denies a secret access request using the approval ID (a GUID) that Secret Server puts in the approval links of its notification emails.
    Use Update-TssSecretAccessRequest instead when you have the numeric access request ID.
    The endpoint accepts anonymous calls; the cmdlet still sends the session token.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER ApprovalId
    Approval ID (GUID) from the approval link

    .PARAMETER Hours
    Number of hours of access to grant when approving

    .PARAMETER Status
    Decision: Approved or Denied

    .PARAMETER V2
    Use the v2 endpoint. Both versions apply the decision the same way

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Submit-TssSecretAccessRequestApproval -TssSession $session -ApprovalId 3f2b8c1e-5d4a-4e7b-9c3d-2a1b0c9d8e7f -Status Approved -Hours 2

    Approve the request behind the approval ID for two hours

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Submit-TssSecretAccessRequestApproval -TssSession $session -ApprovalId 3f2b8c1e-5d4a-4e7b-9c3d-2a1b0c9d8e7f -Status Denied -V2

    Deny the request behind the approval ID, using the v2 endpoint

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-access-requests/Submit-TssSecretAccessRequestApproval

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-access-requests/Submit-TssSecretAccessRequestApproval.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default', SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.AccessRequests.ApprovalResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'Default')]
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'V2')]
        [guid]
        $ApprovalId,

        [Parameter(ParameterSetName = 'Default')]
        [Parameter(ParameterSetName = 'V2')]
        [int]
        $Hours,

        [Parameter(Mandatory, ParameterSetName = 'Default')]
        [Parameter(Mandatory, ParameterSetName = 'V2')]
        [ValidateSet('Approved', 'Denied')]
        [string]
        $Status,

        [Parameter(Mandatory, ParameterSetName = 'V2')]
        [switch]
        $V2
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            switch ($PSCmdlet.ParameterSetName) {
                'V2' {
                    $uri = ($TssSession.ApiUrl -replace '/api/v1$','/api/v2'), 'secret-access-requests', 'approvals', $ApprovalId -join '/'
                    $body = @{ }
                    switch ($tssParams.Keys) {
                        'Hours' {
                            $body.Add('hours', $Hours)
                        }
                        'Status' {
                            $body.Add('status', $Status)
                        }
                    }
                    $invokeParams.Body = $body | ConvertTo-Json -Depth 100
                }
                default {
                    $uri = $TssSession.ApiUrl, 'secret-access-requests', 'approvals', $ApprovalId -join '/'
                    $body = @{ }
                    switch ($tssParams.Keys) {
                        'Hours' {
                            $body.Add('hours', $Hours)
                        }
                        'Status' {
                            $body.Add('status', $Status)
                        }
                    }
                    $invokeParams.Body = $body | ConvertTo-Json -Depth 100
                }
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            if ($PSCmdlet.ShouldProcess("Secret access request approval: $ApprovalId", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Submit-TssSecretAccessRequestApproval request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.AccessRequests.ApprovalResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.AccessRequests.ApprovalResult]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
