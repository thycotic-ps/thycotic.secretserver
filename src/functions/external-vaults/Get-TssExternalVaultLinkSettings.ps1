function Get-TssExternalVaultLinkSettings {
    <#
    .SYNOPSIS
    Get the settings needed to link an external vault

    .DESCRIPTION
    Gets the options for linking a new external vault of the given type: the default name, the password types, and the vaults (Azure, AWS, Google) or namespaces and mount points (HashiCorp) reachable with the credential secret.
    When the options cannot be read, ActionableErrorMessage says why.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER CredentialSecretId
    Id of the secret that holds the credentials used to read the vault options

    .PARAMETER HashiCorpEdition
    HashiCorp Vault edition

    .PARAMETER ExternalVaultType
    Type of external vault to link

    .PARAMETER SiteId
    Distributed engine site used to reach the vault

    .PARAMETER HashiCorpSkipCertificateValidation
    Skip TLS certificate validation when reading a HashiCorp Vault

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssExternalVaultLinkSettings -TssSession $session -ExternalVaultType AzureKeyVault -CredentialSecretId 42

    List the Azure key vaults reachable with the credentials in secret 42

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssExternalVaultLinkSettings -TssSession $session -ExternalVaultType HashiCorpVault -CredentialSecretId 43 -HashiCorpEdition Enterprise -SiteId 2

    List the namespaces and mount points of a HashiCorp Vault Enterprise reached through site 2

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Get-TssExternalVaultLinkSettings

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Get-TssExternalVaultLinkSettings.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.ExternalVaults.LinkSettings')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [int]
        $CredentialSecretId,

        [ValidateSet('Community', 'Enterprise', 'HCP')]
        [string]
        $HashiCorpEdition,

        [Parameter(Mandatory)]
        [ValidateSet('AzureKeyVault', 'AWSSecretsManager', 'GoogleSecretManager', 'HashiCorpVault')]
        [string]
        $ExternalVaultType,

        [int]
        $SiteId,

        [switch]
        $HashiCorpSkipCertificateValidation
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.8.000017' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'external-vaults', 'link-settings' -join '/'
            $queryParams = @()
            switch ($tssParams.Keys) {
                'CredentialSecretId' {
                    $queryParams += "credentialSecretId=$($CredentialSecretId)"
                }
                'HashiCorpEdition' {
                    $queryParams += "edition=$([uri]::EscapeDataString($HashiCorpEdition))"
                }
                'ExternalVaultType' {
                    $queryParams += "externalVaultType=$([uri]::EscapeDataString($ExternalVaultType))"
                }
                'SiteId' {
                    $queryParams += "siteId=$($SiteId)"
                }
                'HashiCorpSkipCertificateValidation' {
                    $queryParams += "skipCertificateValidation=$([boolean]$HashiCorpSkipCertificateValidation)"
                }
            }
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
                Write-Warning 'Issue with Get-TssExternalVaultLinkSettings request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.ExternalVaults.LinkSettings](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.ExternalVaults.LinkSettings]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
