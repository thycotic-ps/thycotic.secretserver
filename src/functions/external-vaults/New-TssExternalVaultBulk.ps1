function New-TssExternalVaultBulk {
    <#
    .SYNOPSIS
    Create several external vaults at once

    .DESCRIPTION
    Creates several external vault links in one request. Each vault definition carries the same fields New-TssExternalVault sends.
    Returns one result per vault, with the created vault or the error for that vault.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Vault
    External vault definitions, one hashtable or object per vault with the keys name, displayName, active, credentialSecretId, externalVaultType (AzureKeyVault, AWSSecretsManager, GoogleSecretManager or HashiCorpVault), optional siteId and, for HashiCorp Vault, hashiCorpConnectionParameters (edition, namespace, mountPoint, kvVersion, skipCertificateValidation)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $vaults = @(@{ name = 'payments-kv'; displayName = 'Payments'; active = $true; credentialSecretId = 42; externalVaultType = 'AzureKeyVault' }, @{ name = 'hr-kv'; displayName = 'HR'; active = $true; credentialSecretId = 42; externalVaultType = 'AzureKeyVault' })
    New-TssExternalVaultBulk -TssSession $session -Vault $vaults

    Create two active Azure Key Vault links that use the credentials in secret 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/New-TssExternalVaultBulk

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/New-TssExternalVaultBulk.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.ExternalVaults.Bulk')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [object[]]
        $Vault
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.8.000017' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'external-vaults', 'vaults', 'bulk-create' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ }
            switch ($tssParams.Keys) {
                'Vault' {
                    $body.Add('vaults', $Vault)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("External vault bulk", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssExternalVaultBulk request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.ExternalVaults.Bulk](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.ExternalVaults.Bulk]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
