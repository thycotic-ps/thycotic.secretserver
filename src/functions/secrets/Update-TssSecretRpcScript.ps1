function Update-TssSecretRpcScript {
    <#
    .SYNOPSIS
    Replace the associated secrets a secret's RPC scripts may use

    .DESCRIPTION
    Replace the list of associated secrets (ResetSecrets) that the remote password changing scripts of a secret may use, and return the secret's RPC settings.
    The list is replaced, not merged: pass every secret that should stay, in order. An empty list clears it.
    Set-TssSecretRpcAssociated changes the same list through the v1 route and returns only the list; this command uses the v3 route (or the v2 route with -V2) and returns the full RPC settings, as Get-TssSecretRpcScript does.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret ID

    .PARAMETER AssociatedSecretId
    Secret IDs the RPC scripts may use, in order; an empty list clears the list

    .PARAMETER V2
    Use the v2 route, for servers without the v3 route

    .PARAMETER AutoCheckIn
    Check the secret in automatically after the request

    .PARAMETER AutoCheckout
    Check the secret out automatically for the request

    .PARAMETER AutoComment
    Comment to use for the automatic check-out

    .PARAMETER ForceCheckIn
    Check the secret in first when another user has it checked out

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssSecretRpcScript -TssSession $session -Id 46 -AssociatedSecretId 12, 13

    Let the RPC scripts of secret 46 use secrets 12 and 13, in that order

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $current = (Get-TssSecretRpcScript -TssSession $session -Id 46).ResetSecrets.SecretId
    Update-TssSecretRpcScript -TssSession $session -Id 46 -AssociatedSecretId (@($current) + 20)

    Append secret 20 to the associated secrets of secret 46

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssSecretRpcScript -TssSession $session -Id 46 -AssociatedSecretId @()

    Clear the associated secrets of secret 46

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Update-TssSecretRpcScript

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Update-TssSecretRpcScript.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Secrets.RpcDetail')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretId')]
        [int]
        $Id,

        [Parameter(Mandatory)]
        [AllowEmptyCollection()]
        [int[]]
        $AssociatedSecretId,

        [switch]
        $V2,

        [switch]
        $AutoCheckIn,

        [switch]
        $AutoCheckout,

        [string]
        $AutoComment,

        [switch]
        $ForceCheckIn
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            if ($V2) {
                $uri = ($TssSession.ApiUrl -replace '/api/v1$','/api/v2'), 'secrets', $Id, 'rpc-script-secrets' -join '/'
            } else {
                $uri = ($TssSession.ApiUrl -replace '/api/v1$','/api/v3'), 'secrets', $Id, 'rpc-script-secrets' -join '/'
            }
            $queryParams = @()
            switch ($tssParams.Keys) {
                'AutoCheckIn' {
                    $queryParams += "autoCheckIn=$([boolean]$AutoCheckIn)"
                }
                'AutoCheckout' {
                    $queryParams += "autoCheckout=$([boolean]$AutoCheckout)"
                }
                'AutoComment' {
                    $queryParams += "autoComment=$([uri]::EscapeDataString($AutoComment))"
                }
                'ForceCheckIn' {
                    $queryParams += "forceCheckIn=$([boolean]$ForceCheckIn)"
                }
            }
            if ($queryParams) {
                $uri = $uri, ($queryParams -join '&') -join '?'
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $body = @{
                data = @{
                    resetSecretIds = @{
                        dirty = $true
                        value = @($AssociatedSecretId)
                    }
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Secret ID: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue updating RPC associated secrets of Secret [$Id]"
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    $rpcDetail = [ordered]@{ }
                    foreach ($property in $restResponse.PSObject.Properties) {
                        $rpcDetail[$property.Name] = $property.Value
                        if ($property.Value -is [pscustomobject] -and $property.Value.PSObject.Properties.Name -contains 'value') {
                            $rpcDetail[$property.Name] = $property.Value.value
                        }
                    }
                    $rpcDetail['resetSecrets'] = @(foreach ($resetSecret in $restResponse.resetSecrets) {
                            if ($resetSecret.PSObject.Properties.Name -contains 'value') { $resetSecret.value } else { $resetSecret }
                        })
                    [Thycotic.PowerShell.Secrets.RpcDetail](. $FilterTssResponse ([pscustomobject]$rpcDetail) ([Thycotic.PowerShell.Secrets.RpcDetail]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
