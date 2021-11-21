function Get-TssSecretPolicyItemStub {
    <#
    .SYNOPSIS
    Get empty object for a specific Secret Policy Item

    .DESCRIPTION
    Get empty object for a specific Secret Policy Item, used with creating or updating

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretPolicyItemStub -TssSession $session - some test value

    Add minimum example for each parameter

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-policies/Get-TssSecretPolicyItemStub

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-policies/Get-TssSecretPolicyItemStub.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SecretPolicies.PolicyItem')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret Policy Item
        [Parameter(Mandatory)]
        [Thycotic.PowerShell.Enums.SecretPolicyItem]
        $ItemName,

        # Policy apply type
        [Thycotic.PowerShell.Enums.SecretPolicyApplyType]
        $ApplyType
    )
    begin {
        $tssParams = $PSBoundParameters
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            $policyStub = Get-TssSecretPolicyStub -TssSession $TssSession
            if ($policyStub) {
                $item = $policyStub.SecretPolicyItems | Where-Object Name -eq $ItemName
                if ($item) {
                    if ($tssParams.ContainsKey('ApplyType')) {
                        $item.PolicyApplyType = $ApplyType
                    }
                    return $item
                } else {
                    Write-Warning "Policy Item [$ItemName] not found on Secret Policy Stub"
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}