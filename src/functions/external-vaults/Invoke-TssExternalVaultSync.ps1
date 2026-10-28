function Invoke-TssExternalVaultSync {
    <#
    .SYNOPSIS
    Push, pull or sync external vault secrets

    .DESCRIPTION
    Push secret values from Secret Server to external vaults, pull external vault secrets into Secret Server, or both (Sync).
    -ExternalVaultId supports Push, Pull and Sync for every active external vault secret in those vaults. -ExternalVaultSecretId and -LinkedSecretId only act on Push.
    The output lists the push results and the pull results, each with the external vault secret or vault, or the error.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Action
    Push (Secret Server to external vault), Pull (external vault to Secret Server) or Sync (both)

    .PARAMETER ExternalVaultId
    External vaults to push, pull or sync

    .PARAMETER ExternalVaultSecretId
    External vault secrets to push (Push only)

    .PARAMETER LinkedSecretId
    Push every external vault secret linked to this Secret Server secret (Push only)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Invoke-TssExternalVaultSync -TssSession $session -Action Sync -ExternalVaultId 3

    Pull and push every active external vault secret in external vault 3

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Invoke-TssExternalVaultSync -TssSession $session -Action Push -LinkedSecretId 42

    Push the value of secret 42 to every external vault secret linked to it

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Invoke-TssExternalVaultSync

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Invoke-TssExternalVaultSync.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.ExternalVaults.Sync')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [ValidateSet('Push', 'Pull', 'Sync')]
        [string]
        $Action,

        [int[]]
        $ExternalVaultId,

        [int[]]
        $ExternalVaultSecretId,

        [int]
        $LinkedSecretId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.7.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'external-vaults', 'sync' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Action' {
                    $body.data.Add('action', $Action)
                }
                'ExternalVaultId' {
                    $body.data.Add('externalVaultIds', $ExternalVaultId)
                }
                'ExternalVaultSecretId' {
                    $body.data.Add('externalVaultSecretIds', $ExternalVaultSecretId)
                }
                'LinkedSecretId' {
                    $body.data.Add('linkedSecretId', $LinkedSecretId)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Invoke-TssExternalVaultSync request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.ExternalVaults.Sync](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.ExternalVaults.Sync]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
