function Get-TssSecretForceCheckoutDetail {
    <#
    .SYNOPSIS
    Get details of a pending force checkout request on a secret

    .DESCRIPTION
    Returns the secret name, the requester name, and whether the request was already approved.
    Approvers use it to review a request before calling Approve-TssSecretForceCheckout.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER RequesterId
    ID of the user who filed the request

    .PARAMETER SecretId
    Secret ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretForceCheckoutDetail -TssSession $session -SecretId 42 -RequesterId 7

    Returns the force checkout request user 7 filed on secret 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretForceCheckoutDetail

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretForceCheckoutDetail.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Secrets.ForceCheckoutDetail')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $RequesterId,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $SecretId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secrets', 'get-force-checkout-request-details', $SecretId, $RequesterId -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssSecretForceCheckoutDetail request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Secrets.ForceCheckoutDetail](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Secrets.ForceCheckoutDetail]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
