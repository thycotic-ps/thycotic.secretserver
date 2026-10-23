function Update-TssSecretSecurityApproval {
    <#
    .SYNOPSIS
    Update the approval settings of a secret

    .DESCRIPTION
    Sets whether viewing the secret requires approval, who approves, and the access request workflow.
    Only the settings passed are changed; Secret Server requires ApproverGroupId when turning approval on. Returns the updated security settings and a success flag.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret ID

    .PARAMETER AutoCheckIn
    Check the secret back in after the request completes

    .PARAMETER AutoCheckout
    Check out the secret automatically when it requires checkout

    .PARAMETER AutoComment
    Comment to record with the automatic checkout, for secrets that require a comment

    .PARAMETER ForceCheckIn
    Force check in the secret if another user has it checked out

    .PARAMETER ApproverGroupId
    Group ID of each approver; a user approves through the user personal group. Replaces the whole approver list

    .PARAMETER RequireApprovalType
    Who needs approval to access the secret. RequireApproval covers viewers only and RequireEditorsApproval adds editors. When the configuration forces approval for editors, Secret Server reports RequireApproval as RequireEditorsApproval but still stores viewers-only approval

    .PARAMETER WorkflowTemplateId
    ID of the access request workflow template

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssSecretSecurityApproval -TssSession $session -Id 42 -RequireApprovalType RequireEditorsApproval -ApproverGroupId 3, 15

    Requires approval for editors of secret 42, approved by groups 3 and 15

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssSecretSecurityApproval -TssSession $session -Id 42 -RequireApprovalType None

    Turns off approval on secret 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Update-TssSecretSecurityApproval

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Update-TssSecretSecurityApproval.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Secrets.SecurityApproval')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretId')]
        [int]
        $Id,

        [switch]
        $AutoCheckIn,

        [switch]
        $AutoCheckout,

        [string]
        $AutoComment,

        [switch]
        $ForceCheckIn,

        [int[]]
        $ApproverGroupId,

        [ValidateSet('None', 'RequireApproval', 'RequireEditorsApproval', 'RequireOwnersApproval', 'RequireEveryoneApproval')]
        [string]
        $RequireApprovalType,

        [int]
        $WorkflowTemplateId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = ($TssSession.ApiUrl -replace '/api/v1$','/api/v3'), 'secrets', $Id, 'security-approval' -join '/'
            $queryParams = @()
            switch ($tssParams.Keys) {
                'AutoCheckIn' {
                    $queryParams += "autoCheckIn=$([boolean]$AutoCheckIn)"
                }
                'AutoCheckout' {
                    $queryParams += "autoCheckout=$([boolean]$AutoCheckout)"
                }
                'AutoComment' {
                    $queryParams += "autoComment=$([uri]::EscapeDataString($AutoComment))"
                }
                'ForceCheckIn' {
                    $queryParams += "forceCheckIn=$([boolean]$ForceCheckIn)"
                }
            }
            if ($queryParams) {
                $uri = $uri, ($queryParams -join '&') -join '?'
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'ApproverGroupId' {
                    $body.data.Add('approvers', @{ dirty = $true; value = $ApproverGroupId })
                }
                'RequireApprovalType' {
                    $body.data.Add('requireApprovalType', @{ dirty = $true; value = $RequireApprovalType })
                }
                'WorkflowTemplateId' {
                    $body.data.Add('workflowTemplateId', @{ dirty = $true; value = $WorkflowTemplateId })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Secret security approval: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssSecretSecurityApproval request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Secrets.SecurityApproval](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Secrets.SecurityApproval]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
