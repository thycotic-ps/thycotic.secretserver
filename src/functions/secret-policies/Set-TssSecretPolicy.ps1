function Set-TssSecretPolicy {
    <#
    .SYNOPSIS
    Set a Secret Policy property

    .DESCRIPTION
    Set a Secret Policy property

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential ssCred
    Set-TssSecretPolicy -TssSession $session -Id 52 -Active:$false

    Set Secret Policy ID 52 to inactive, changing Active property to false

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential ssCred
    $cPolicy = Get-TssSecretPolicy -TssSession $session -Id 1
    $cPolicy.SecretPolicyItems[0].ValueSecretId = 43
    Set-TssSecretPolicy -TssSession $session -Id 1 -PolicyItem $cPolicy.SecretPolicyItems[0]

    Get current Secret Policy ID 1, set the ValueSecretId to 43 (for the AssociatedSecretId1 item)

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-policies/Set-TssSecretPolicy

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-policies/Set-TssSecretPolicy.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess, DefaultParameterSetName = 'policy')]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret Policy ID
        [Parameter(Mandatory, ParameterSetName = 'policy')]
        [Parameter(Mandatory, ParameterSetName = 'item')]
        [Alias('SecretPolicyId')]
        [int]
        $Id,

        # Secret Policy Name
        [Parameter(ParameterSetName = 'policy')]
        [string]
        $Name,

        # Secret Policy Description
        [Parameter(ParameterSetName = 'policy')]
        [string]
        $Description,

        # Secret Policy Active or Inactive
        [Parameter(ParameterSetName = 'policy')]
        [switch]
        $Active,

        # Policy Item(s) to add (utilize Get-TssSecretPolicyItemStub to create each object)
        [Thycotic.PowerShell.SecretPolicies.PolicyItem[]]
        $PolicyItem
    )
    begin {
        $setParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($setParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.0.000005' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'secret-policy', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'

            $setPolicyBody = @{data = @{} }
            switch ($setParams.Keys) {
                'Name' {
                    $setName = @{
                        dirty = $true
                        value = $Name
                    }
                    $setPolicyBody.data.Add('secretPolicyName',$setName)
                }
                'Description' {
                    $setDesc = @{
                        dirty = $true
                        value = $Description
                    }
                    $setPolicyBody.data.Add('secretPolicyDescription',$setDesc)
                }
                'Active' {
                    $setActive = @{
                        dirty = $true
                        value = $Active
                    }
                    $setPolicyBody.Add('Active',$setActive)
                }
            }

            if ($setParams.ContainsKey('PolicyItem')) {
                $bodyItems = @()
                foreach ($item in $PolicyItem) {
                    $cPolicyItem = @{}
                    $applyType = @{
                        dirty = $true
                        value = [string]$item.PolicyApplyType
                    }
                    $cPolicyItem.Add('policyApplyType',$applyType)

                    $cPolicyItem.Add('secretPolicyItemId',[string]$item.SecretPolicyItemId)

                    if ($item.SshCommandMenuGroupMaps) {
                        $sshCommandMenu = @{
                            dirty = $true
                            value = $item.SshCommandMenuGroupMaps | ConvertTo-Json -Depth 25 | ConvertFrom-Json
                        }
                        $cPolicyItem.Add('sshCommandMenuGroupMaps',$sshCommandMenu)
                    }
                    $ugMaps = @{
                        dirty = $true
                        value = $item.UserGroupMaps | ConvertTo-Json -Depth 25 | ConvertFrom-Json
                    }
                    $cPolicyItem.Add('userGroupMaps',$ugMaps)

                    $vBool = @{
                        dirty = $true
                        value = $item.ValueBool
                    }
                    $cPolicyItem.Add('valueBool',$vBool)

                    $vInt = @{
                        dirty = $true
                        value = $item.ValueInt
                    }
                    $cPolicyItem.Add('valueInt',$vInt)

                    $vSecretId = @{
                        dirty = $true
                        value = $item.ValueSecretId
                    }
                    $cPolicyItem.Add('valueSecretId',$vSecretId)

                    $vString = @{
                        dirty = $true
                        value = $item.ValueString
                    }
                    $cPolicyItem.Add('valueString',$vString)
                    $bodyItems += $cPolicyItem
                }
                $setPolicyBody.data.Add('secretPolicyItems',$bodyItems)
            }
            $invokeParams.Body = $setPolicyBody | ConvertTo-Json -Depth 100

            if ($PSCmdlet.ShouldProcess("description: $Primary Parameter", "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)")) {
                Write-Verbose "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue setting Secret Policy [$Id]'
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    Write-Verbose "Secret Policy [$Id] set successfully"
                } else {
                    Write-Warning "No change made to Secret Policy [$Id], see previous output for errors"
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}