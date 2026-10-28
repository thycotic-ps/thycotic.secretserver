function Search-TssEventPipelinePolicySecretPolicy {
    <#
    .SYNOPSIS
    Get the secret policies that use an event pipeline policy

    .DESCRIPTION
    Returns the secret policies an event pipeline policy is assigned to.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Event pipeline policy ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssEventPipelinePolicySecretPolicy -TssSession $session -Id 3

    Returns the secret policies that use event pipeline policy 3

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policies/Search-TssEventPipelinePolicySecretPolicy

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Search-TssEventPipelinePolicySecretPolicy.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SecretPolicies.Summary[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('EventPipelinePolicyId')]
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
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'event-pipeline-policy', $currentId, 'secretpolicies' -join '/'
                $queryParams = @()
                $queryParams += "take=$($TssSession.Take)"
                if ($queryParams) {
                    $uri = $uri, ($queryParams -join '&') -join '?'
                }
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Search-TssEventPipelinePolicySecretPolicy request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.records) {
                    foreach ($record in $restResponse.records) {
                        [Thycotic.PowerShell.SecretPolicies.Summary]@{
                            Active                  = $record.active.value
                            SecretPolicyDescription = $record.secretPolicyDescription.value
                            SecretPolicyId          = $record.secretPolicyId
                            SecretPolicyName        = $record.secretPolicyName.value
                        }
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
