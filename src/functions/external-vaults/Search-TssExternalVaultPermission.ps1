function Search-TssExternalVaultPermission {
    <#
    .SYNOPSIS
    Search the permissions of an external vault

    .DESCRIPTION
    Search the user and group permissions on an external vault.
    Each record shows the user or group and the external vault permissions it holds.
    Edit the records and pass them to Update-TssExternalVaultPermission to change them.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    External vault ID

    .PARAMETER SearchText
    Filter on user or group name

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssExternalVaultPermission -TssSession $session -Id 3

    Get all permissions on external vault 3

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssExternalVaultPermission -TssSession $session -Id 3 -SearchText 'Vault Admins'

    Get the permissions on external vault 3 for users or groups matching Vault Admins

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Search-TssExternalVaultPermission

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Search-TssExternalVaultPermission.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.ExternalVaults.Permission[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ExternalVaultId')]
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
                $uri = $TssSession.ApiUrl, 'external-vaults', 'vaults', $currentId, 'permissions' -join '/'
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
                    Write-Warning 'Issue with Search-TssExternalVaultPermission request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.records) {
                    [Thycotic.PowerShell.ExternalVaults.Permission[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.ExternalVaults.Permission]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
