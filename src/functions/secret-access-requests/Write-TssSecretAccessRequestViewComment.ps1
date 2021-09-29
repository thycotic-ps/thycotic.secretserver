function Write-TssSecretAccessRequestViewComment {
    <#
    .SYNOPSIS
    Write a View Comment to a Secret

    .DESCRIPTION
    Write a View Comment to a Secret, will be an Audit Action VIEW.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Write-TssSecretAccessRequestViewComment -TssSession $session -Id 46 -Comment "A test comment"

    Writes the comment "A test comment" to Secret ID 46

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-access-requests/Write-TssSecretAccessRequestViewComment

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-access-requests/Write-TssSecretAccessRequestViewComment.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretId')]
        [int[]]
        $Id,

        # Comment to provide for restricted secret (Require Comment is enabled)
        [string]
        $Comment,

        # Associated ticket number (required for ticket integrations)
        [string]
        $TicketNumber,

        # Associated ticket system ID (required for ticket integrations)
        [int]
        $TicketSystemId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($secret in $Id) {
                $uri = $TssSession.ApiUrl, 'secret-access-requests', 'secrets', $secret, 'view-comment' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'

                $writeViewBody = @{}
                switch ($tssParams.Keys) {
                    'Comment' { $writeViewBody.Add('comment', $Comment) }
                    'TicketNumber' { $writeViewBody.Add('ticketNumber', $TicketNumber) }
                    'TicketSystemId' { $writeViewBody.Add('ticketSystemId', $TicketSystemId) }
                }
                $invokeParams.Body = $writeViewBody | ConvertTo-Json
                if ($PSCmdlet.ShouldProcess("Secret ID: $secret", "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri with: `n$($invokeParams.Body)"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue writing view comment to Secret [$secret]"
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if ($restResponse) {
                        Write-Verbose "Comment successfully written to Secret [$secret]"
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}