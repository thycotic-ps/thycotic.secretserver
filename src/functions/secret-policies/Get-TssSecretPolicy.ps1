function Get-TssSecretPolicy {
    <#
    .SYNOPSIS
    Get Secret Policy by ID

    .DESCRIPTION
    Get Secret Policy by ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretPolicy -TssSession $session -Id 4

    Output Secret Policy ID 4

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretPolicy -TssSession $session -Id 4,56,23

    Output Secret Policy ID 4, 56, and 23

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-policies/Get-TssSecretPolicy

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-policies/Get-TssSecretPolicy.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SecretPolicies.Policy')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret Policy ID
        [Parameter(Mandatory,ValueFromPipelineByPropertyName,Position = 1)]
        [Alias("SecretPolicyId")]
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
            foreach ($policy in $Id) {
                $uri = $TssSession.ApiUrl, 'secret-policy', $policy -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with $body"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue getting Secret Policy [$policy]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    [Thycotic.PowerShell.SecretPolicies.Policy[]]$restResponse
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}