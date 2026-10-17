function Get-TssSecretRpcScript {
    <#
    .SYNOPSIS
    Get the remote password changing settings of a secret, with the secrets its RPC scripts may use

    .DESCRIPTION
    Get the remote password changing (RPC) settings of a secret: auto change and its schedule, the password changer, the privileged account, the current change status and the associated secrets (ResetSecrets) its RPC scripts may use.
    Values the server wraps in view fields are returned as plain values.
    Replace the associated secrets with Update-TssSecretRpcScript.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret ID

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
    Get-TssSecretRpcScript -TssSession $session -Id 46

    Get the RPC settings of secret 46

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    (Get-TssSecretRpcScript -TssSession $session -Id 46).ResetSecrets | Select-Object Order, SecretId, SecretName

    List the associated secrets the RPC scripts of secret 46 may use, in order

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretRpcScript

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretRpcScript.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Secrets.RpcDetail')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretId')]
        [int[]]
        $Id,

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
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = ($TssSession.ApiUrl -replace '/api/v1$','/api/v3'), 'secrets', $currentId, 'rpc-script-secrets' -join '/'
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
                    Write-Warning "Issue getting RPC settings of Secret [$currentId]"
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
