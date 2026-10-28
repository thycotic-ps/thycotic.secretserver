function Get-TssSecretPolicyStatus {
    <#
    .SYNOPSIS
    Get the application status of a Secret Policy

    .DESCRIPTION
    Returns how many secrets the Secret Policy is applied to, how many are still queued to pick it up, and the completion ratio between 0 and 1.
    Secret Server returns zero counts rather than an error for an ID that matches no Secret Policy.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret Policy ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretPolicyStatus -TssSession $session -Id 4

    Returns the application status of Secret Policy ID 4

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecretPolicy -TssSession $session -IncludeInactive | Get-TssSecretPolicyStatus -TssSession $session

    Returns the application status of every Secret Policy

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-policies/Get-TssSecretPolicyStatus

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-policies/Get-TssSecretPolicyStatus.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SecretPolicies.Status')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretPolicyId')]
        [int[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.0.000005' $PSCmdlet.MyInvocation
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secret-policy', $currentId, 'status' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssSecretPolicyStatus request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.SecretPolicies.Status](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SecretPolicies.Status]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
