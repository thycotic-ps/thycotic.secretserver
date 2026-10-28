function Set-TssExternalVault {
    <#
    .SYNOPSIS
    Update an external vault

    .DESCRIPTION
    Updates an existing external vault link. Only the parameters you pass are changed. The name and type of a vault cannot be changed.
    Returns the updated external vault.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    External vault id

    .PARAMETER Active
    Activate the external vault, or pass -Active:$false to deactivate it

    .PARAMETER CredentialSecretId
    Id of the secret that holds the credentials of the external vault

    .PARAMETER DisplayName
    Display name of the external vault

    .PARAMETER HashiCorpSkipCertificateValidation
    Skip TLS certificate validation when connecting to HashiCorp Vault, or pass -HashiCorpSkipCertificateValidation:$false to validate certificates (HashiCorp Vault only)

    .PARAMETER SecretRegex
    Regular expression that limits which external secrets are listed

    .PARAMETER SiteId
    Distributed engine site used to reach the external vault

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssExternalVault -TssSession $session -Id 2 -DisplayName Payments -CredentialSecretId 44

    Rename external vault 2 and point it at the credentials in secret 44

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssExternalVault -TssSession $session -Id 3 -HashiCorpSkipCertificateValidation:$false

    Turn certificate validation back on for HashiCorp Vault link 3

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Set-TssExternalVault

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Set-TssExternalVault.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.ExternalVaults.ExternalVault')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ExternalVaultId')]
        [int]
        $Id,

        [switch]
        $Active,

        [int]
        $CredentialSecretId,

        [string]
        $DisplayName,

        [switch]
        $HashiCorpSkipCertificateValidation,

        [string]
        $SecretRegex,

        [int]
        $SiteId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.7.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'external-vaults', 'vaults', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Active' {
                    $body.data.Add('active', @{ dirty = $true; value = [boolean]$Active })
                }
                'CredentialSecretId' {
                    $body.data.Add('credentialSecretId', @{ dirty = $true; value = $CredentialSecretId })
                }
                'DisplayName' {
                    $body.data.Add('displayName', @{ dirty = $true; value = $DisplayName })
                }
                'HashiCorpSkipCertificateValidation' {
                    $body.data.Add('hashiCorpConnectionParameters', @{ skipCertificateValidation = @{ dirty = $true; value = [boolean]$HashiCorpSkipCertificateValidation } })
                }
                'SecretRegex' {
                    $body.data.Add('secretRegex', @{ dirty = $true; value = $SecretRegex })
                }
                'SiteId' {
                    $body.data.Add('siteId', @{ dirty = $true; value = $SiteId })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("External vault: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssExternalVault request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.ExternalVaults.ExternalVault](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.ExternalVaults.ExternalVault]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
