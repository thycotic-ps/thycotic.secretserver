function New-TssSecretPolicy {
    <#
    .SYNOPSIS
    Create a new Secret Policy

    .DESCRIPTION
    Create a new Secret Policy, configure Policy Items using Update-TssSecretPolicy

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-policies/New-TssSecretPolicy

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-policies/New-TssSecretPolicy.ps1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssSecretPolicy -TssSession $session -Name 'Require Checkout'

    Create a new secret policy setting enforcing various policy items

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $policyItem1 = Get-TssSecretPolicyItemStub -TssSession $session -ItemName AssociatedSecretId1 -ApplyType Enforced
    $policyItem1.ValueSecretId = 54
    $policyItem2 = Get-TssSecretPolicyItemStub -TssSession $session -ItemName AssociatedSecretId2 -ApplyType Enforced
    $policyItem2.ValueSecretId = 65
    New-TssSecretPolicy -TssSession $session -Name 'Policy - Associated Secrets Enforced' -Active -PolicyItem $policyItem1, $policyItem2

    Create a new secret policy, configuring Associated Secret 1 and 2 policy items.

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SecretPolicies.Policy')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret Policy Name
        [Parameter(Mandatory)]
        [string]
        $Name,

        # Secret Policy Description
        [string]
        $Description,

        # Activate the policy after creation
        [switch]
        $Active,

        # Policy Item(s) to add (utilize Get-TssSecretPolicyItemStub to create each object)
        [Thycotic.PowerShell.SecretPolicies.PolicyItem[]]
        $PolicyItem
    )
    begin {
        $tssNewParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssNewParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.0.000005' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secret-policy' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'

            $newBody = @{data = @{} }
            switch ($tssNewParams.Keys) {
                'Name' { $newBody.data.Add('secretPolicyName',$Name) }
                'Description' { $newBody.data.Add('secretPolicyDescription',$Description) }
                'Active' { $newBody.data.Add('active',[boolean]$Active) }
            }

            if ($tssNewParams.ContainsKey('PolicyItem')) {
                $bodyItems = @()
                foreach ($item in $PolicyItem) {
                    $item | ConvertTo-Json -Depth 80 | ConvertFrom-Json

                    $bodyItems += [pscustomobject]@{
                        policyApplyType = $item.PolicyApplyType
                        secretPolicyItemId = $item.SecretPolicyItemId
                        valueBool = $item.ValueBool
                        valueInt = $item.ValueInt
                        valueSecretId = $item.ValueSecretId
                        valueString = $item.ValueString
                        userGroupMaps = $item.UserGroupMaps
                        sshCommandMenuGroupMaps = $item.SshCommandMenuGroupMaps
                    }
                }
                $newBody.data.Add('secretPolicyItems',$bodyItems)
            }

            $invokeParams.Body = $newBody | ConvertTo-Json -Depth 100

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri) with:`n $newBody"
            if (-not $PSCmdlet.ShouldProcess("Secret Policy: $Name", "$($invokeParams.Method) $($invokeParams.Uri) with $($invokeParams.Body)")) { return }
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue creating Secret Policy [$Name]"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                [Thycotic.PowerShell.SecretPolicies.Policy]$restResponse
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}