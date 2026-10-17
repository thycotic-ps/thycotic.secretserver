function Search-TssExternalVaultSecret {
    <#
    .SYNOPSIS
    Search external vault secrets

    .DESCRIPTION
    Search the external vault secrets linked to Secret Server secrets.
    Filters combine: status, external vault type, external vault, linked secret and external vault secret ID.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER ExternalVaultSecretId
    Only return these external vault secret IDs

    .PARAMETER ExternalVaultId
    Only return external vault secrets in these external vaults

    .PARAMETER ExternalVaultType
    Only return external vault secrets in these external vault types

    .PARAMETER LinkedSecretId
    Only return external vault secrets linked to this Secret Server secret

    .PARAMETER SearchText
    Filter on external vault secret name

    .PARAMETER Status
    Only return Active or Inactive external vault secrets, or All for both. Without -Status only active external vault secrets are returned.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssExternalVaultSecret -TssSession $session -LinkedSecretId 42

    Get the external vault secrets linked to secret 42

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssExternalVaultSecret -TssSession $session -ExternalVaultType HashiCorpVault -Status Active

    Get the active external vault secrets in HashiCorp Vault external vaults

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Search-TssExternalVaultSecret

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Search-TssExternalVaultSecret.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.ExternalVaults.SecretItem[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [int[]]
        $ExternalVaultSecretId,

        [int[]]
        $ExternalVaultId,

        [ValidateSet('AzureKeyVault', 'AWSSecretsManager', 'GoogleSecretManager', 'HashiCorpVault')]
        [string[]]
        $ExternalVaultType,

        [int]
        $LinkedSecretId,

        [string]
        $SearchText,

        [ValidateSet('All', 'Active', 'Inactive')]
        [string]
        $Status
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.7.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'external-vaults', 'secrets', 'search' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'ExternalVaultSecretId' {
                    foreach ($queryValue in $ExternalVaultSecretId) {
                        $queryParams += "filter.externalSecretIds=$($queryValue)"
                    }
                }
                'ExternalVaultId' {
                    foreach ($queryValue in $ExternalVaultId) {
                        $queryParams += "filter.externalVaultIds=$($queryValue)"
                    }
                }
                'ExternalVaultType' {
                    foreach ($queryValue in $ExternalVaultType) {
                        $queryParams += "filter.externalVaultTypes=$([uri]::EscapeDataString($queryValue))"
                    }
                }
                'LinkedSecretId' {
                    $queryParams += "filter.linkedSecretId=$($LinkedSecretId)"
                }
                'SearchText' {
                    $queryParams += "filter.searchText=$([uri]::EscapeDataString($SearchText))"
                }
                'Status' {
                    $queryParams += "filter.status=$([uri]::EscapeDataString($Status))"
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
                Write-Warning 'Issue with Search-TssExternalVaultSecret request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.ExternalVaults.SecretItem[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.ExternalVaults.SecretItem]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
