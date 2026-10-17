function Search-TssExternalVaultSecretPermission {
    <#
    .SYNOPSIS
    Search the permissions of an external vault secret

    .DESCRIPTION
    Search the user and group permissions set on an external vault secret.
    Edit the records and pass them to Update-TssExternalVaultSecretPermission to change them.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    External vault secret ID

    .PARAMETER SearchText
    Filter on user or group name

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssExternalVaultSecretPermission -TssSession $session -Id 12

    Get the permissions on external vault secret 12

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Search-TssExternalVaultSecretPermission

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Search-TssExternalVaultSecretPermission.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.ExternalVaults.SecretPermission[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ExternalVaultSecretId')]
        [int[]]
        $Id,

        [string]
        $SearchText
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.7.000000' $PSCmdlet.MyInvocation
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'external-vaults', 'vaults', 'secrets', $currentId, 'permissions' -join '/'
                $queryParams = @()
                $queryParams += "take=$($TssSession.Take)"
                switch ($tssParams.Keys) {
                    'SearchText' {
                        $queryParams += "filter.searchText=$([uri]::EscapeDataString($SearchText))"
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
                    Write-Warning 'Issue with Search-TssExternalVaultSecretPermission request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.records) {
                    [Thycotic.PowerShell.ExternalVaults.SecretPermission[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.ExternalVaults.SecretPermission]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
