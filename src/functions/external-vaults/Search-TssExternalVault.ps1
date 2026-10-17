function Search-TssExternalVault {
    <#
    .SYNOPSIS
    Search external vaults

    .DESCRIPTION
    Lists the external vault links the current user can view, optionally filtered by name, type and status. Without -Status only active vaults are returned.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER ExternalVaultType
    Only return external vaults of these types

    .PARAMETER SearchText
    Only return external vaults whose name matches this text

    .PARAMETER Status
    Return Active (server default), Inactive or All external vaults

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssExternalVault -TssSession $session

    List the active external vaults

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssExternalVault -TssSession $session -ExternalVaultType AzureKeyVault, AWSSecretsManager -Status All

    List every Azure Key Vault and AWS Secrets Manager link, inactive included

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Search-TssExternalVault

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Search-TssExternalVault.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.ExternalVaults.ExternalVaultItem[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [ValidateSet('AzureKeyVault', 'AWSSecretsManager', 'GoogleSecretManager', 'HashiCorpVault')]
        [string[]]
        $ExternalVaultType,

        [string]
        $SearchText,

        [ValidateSet('Active', 'Inactive', 'All')]
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
            $uri = $TssSession.ApiUrl, 'external-vaults', 'vaults', 'search' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'ExternalVaultType' {
                    foreach ($queryValue in $ExternalVaultType) {
                        $queryParams += "filter.externalVaultTypes=$([uri]::EscapeDataString($queryValue))"
                    }
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
                Write-Warning 'Issue with Search-TssExternalVault request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.ExternalVaults.ExternalVaultItem[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.ExternalVaults.ExternalVaultItem]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
