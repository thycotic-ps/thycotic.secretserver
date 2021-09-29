function Set-TssSecretRpcAssociated {
    <#
    .SYNOPSIS
    Set a Secret's Associated Secret for RPC Scripts

    .DESCRIPTION
    Set a Secret's Associated Secret for RPC Scripts

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSecretRpcAssociated -TssSession $session -Id 42 -AssociateSecretId 342,242

    Will update Secret 42 and set the Associated Secrets to 342 (index 1) and 242 (index 2). This will overwrite any currently Associated Secrets.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha/SecretServer -Credential $ssCred
    $current = Get-TssSecretRpcAssociated -TssSession $session -Id 330
    $updatedList = $current.AssociatedSecrets
    $updatedList += 42
    Set-TssSecretRpcAssociated -TssSession $session -AssociatedSecretId $updatedList

    Pull the current Associated Secrets on Secret ID 330, add the Secret ID 42 to the end of that list (order 3), and then update Secret ID 330

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Set-TssSecretRpcAssociated

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Set-TssSecretRpcAssociated.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ParentSecretId')]
        [int[]]
        $Id,

        # Secret IDs to Associate
        [Parameter(Mandatory, ValueFromRemainingArguments)]
        [int[]]
        $AssociatedSecretId
    )
    begin {
        $setParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($setParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($secret in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secrets', $secret, 'rpc-script-secrets' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'PUT'

                $setBody = @{
                    data = @{
                        resetSecretIds = @{
                            dirty = $true
                            value = $AssociatedSecretId
                        }
                    }
                }
                $invokeParams.Body = $setBody | ConvertTo-Json -Depth 5

                if ($PSCmdlet.ShouldProcess("Secret ID: $secret", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue setting Associated Secrets on Secret [$secret]"
                        $err = $_
                        . $ErrorHandling $err
                    }
                }
                if ($restResponse.resetSecrets.value) {
                    $associated = $restResponse.resetSecrets.value
                    if (Compare-Object $associated.secretId $AssociatedSecretId) {
                        Write-Warning "Associated Secrets for Secret [$secret] not updated"
                    } else {
                        Write-Verbose "Associated Secrets for Secret [$secret] updated successfully"
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}