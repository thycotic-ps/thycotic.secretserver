function New-TssExternalVault {
    <#
    .SYNOPSIS
    Create an external vault

    .DESCRIPTION
    Creates an external vault link to Azure Key Vault, AWS Secrets Manager, Google Secret Manager or HashiCorp Vault. The credential secret holds the credentials the vault type expects.
    Use Get-TssExternalVaultLinkSettings first to list the vaults, namespaces and mount points the credential secret can reach.
    For HashiCorp Vault, set the connection with the HashiCorp parameters. A self-hosted HashiCorp Vault also needs -SiteId.
    Use -Active to create the vault active. Without -Active the vault is created inactive.
    Returns the created external vault.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Active
    Create the external vault active. Omit to create it inactive

    .PARAMETER CredentialSecretId
    Id of the secret that holds the credentials of the external vault

    .PARAMETER DisplayName
    Display name of the external vault

    .PARAMETER ExternalVaultType
    Type of the external vault

    .PARAMETER HashiCorpEdition
    HashiCorp Vault edition (HashiCorp Vault only, default Community)

    .PARAMETER HashiCorpKvVersion
    Version of the HashiCorp KV secrets engine (HashiCorp Vault only, default 2)

    .PARAMETER HashiCorpMountPoint
    Mount point of the HashiCorp KV secrets engine (HashiCorp Vault only)

    .PARAMETER HashiCorpNamespace
    HashiCorp Vault namespace (HashiCorp Vault only)

    .PARAMETER HashiCorpSkipCertificateValidation
    Skip TLS certificate validation when connecting to HashiCorp Vault (HashiCorp Vault only)

    .PARAMETER Name
    Name of the vault in the external system

    .PARAMETER SecretRegex
    Regular expression that limits which external secrets are listed

    .PARAMETER SiteId
    Distributed engine site used to reach the external vault (required for a self-hosted HashiCorp Vault)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssExternalVault -TssSession $session -Name payments-kv -DisplayName Payments -ExternalVaultType AzureKeyVault -CredentialSecretId 42 -Active

    Create an active link to the Azure Key Vault payments-kv using the credentials in secret 42

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssExternalVault -TssSession $session -Name kv -ExternalVaultType HashiCorpVault -CredentialSecretId 43 -SiteId 2 -HashiCorpEdition Enterprise -HashiCorpNamespace team-a -HashiCorpMountPoint kv -HashiCorpKvVersion 2 -Active

    Create an active link to the kv mount of a self-hosted HashiCorp Vault Enterprise namespace, reached through site 2

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/New-TssExternalVault

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/New-TssExternalVault.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.ExternalVaults.ExternalVault')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $Active,

        [Parameter(Mandatory)]
        [int]
        $CredentialSecretId,

        [string]
        $DisplayName,

        [Parameter(Mandatory)]
        [ValidateSet('AzureKeyVault', 'AWSSecretsManager', 'GoogleSecretManager', 'HashiCorpVault')]
        [string]
        $ExternalVaultType,

        [ValidateSet('Community', 'Enterprise', 'HCP')]
        [string]
        $HashiCorpEdition = 'Community',

        [int]
        $HashiCorpKvVersion = 2,

        [string]
        $HashiCorpMountPoint,

        [string]
        $HashiCorpNamespace,

        [switch]
        $HashiCorpSkipCertificateValidation,

        [Parameter(Mandatory)]
        [string]
        $Name,

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
            $uri = $TssSession.ApiUrl, 'external-vaults', 'vaults' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Active' {
                    $body.data.Add('active', [boolean]$Active)
                }
                'CredentialSecretId' {
                    $body.data.Add('credentialSecretId', $CredentialSecretId)
                }
                'DisplayName' {
                    $body.data.Add('displayName', $DisplayName)
                }
                'ExternalVaultType' {
                    $body.data.Add('externalVaultType', $ExternalVaultType)
                }
                'Name' {
                    $body.data.Add('name', $Name)
                }
                'SecretRegex' {
                    $body.data.Add('secretRegex', $SecretRegex)
                }
                'SiteId' {
                    $body.data.Add('siteId', $SiteId)
                }
            }
            if ($ExternalVaultType -eq 'HashiCorpVault') {
                $hashiCorpParameters = @{
                    edition                   = $HashiCorpEdition
                    kvVersion                 = $HashiCorpKvVersion
                    skipCertificateValidation = [boolean]$HashiCorpSkipCertificateValidation
                }
                switch ($tssParams.Keys) {
                    'HashiCorpMountPoint' {
                        $hashiCorpParameters.Add('mountPoint', $HashiCorpMountPoint)
                    }
                    'HashiCorpNamespace' {
                        $hashiCorpParameters.Add('namespace', $HashiCorpNamespace)
                    }
                }
                $body.data.Add('hashiCorpConnectionParameters', $hashiCorpParameters)
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("External vault", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssExternalVault request'
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
