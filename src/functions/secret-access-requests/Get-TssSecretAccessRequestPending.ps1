function Get-TssSecretAccessRequestPending {
    <#
    .SYNOPSIS
    Get a secret access request with its current and eligible reviewers

    .DESCRIPTION
    Returns a secret access request by ID. While the request is Pending the result also lists the approvers of the current workflow step and the reviewers eligible to act on it.
    Without -V2 a revoked request is reported as Denied; with -V2 the Revoked state is returned.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret access request ID

    .PARAMETER V2
    Use the v2 endpoint. v2 returns the Revoked state; v1 reports a revoked request as Denied

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretAccessRequestPending -TssSession $session -Id 17

    Get access request 17 with its current and eligible reviewers

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretAccessRequestPending -TssSession $session -Id 17 -V2

    Get access request 17 using the v2 endpoint, which reports the Revoked state

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-access-requests/Get-TssSecretAccessRequestPending

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-access-requests/Get-TssSecretAccessRequestPending.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    [OutputType('Thycotic.PowerShell.AccessRequests.Pending')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'Default')]
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'V2')]
        [Alias('SecretAccessRequestId')]
        [int[]]
        $Id,

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
            foreach ($currentId in $Id) {
                $restResponse = $null
                switch ($PSCmdlet.ParameterSetName) {
                    'V2' {
                        $uri = ($TssSession.ApiUrl -replace '/api/v1$','/api/v2'), 'secret-access-requests', $currentId, 'pending' -join '/'
                    }
                    default {
                        $uri = $TssSession.ApiUrl, 'secret-access-requests', $currentId, 'pending' -join '/'
                    }
                }
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssSecretAccessRequestPending request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.AccessRequests.Pending](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.AccessRequests.Pending]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
