function Get-TssExternalVaultSecretPermissionHistory {
    <#
    .SYNOPSIS
    Get the permission change history of an external vault secret

    .DESCRIPTION
    Get the permission change history of an external vault secret for one permission change.
    Each permission change writes a shared audit entry; -AuditId picks the change and only the records it wrote are returned.
    Each record shows a group, the permission it held, who changed it and when, and whether it was removed.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    External vault secret ID

    .PARAMETER AuditId
    Shared audit ID of the permission change (audit type ExternalVaultSecret, action EDIT PERMISSIONS)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssExternalVaultSecretPermissionHistory -TssSession $session -Id 12 -AuditId 1520

    Get the permission records that the change audited as 1520 wrote for external vault secret 12

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $change = Search-TssSharedAudit -TssSession $session -AuditType ExternalVaultSecret -ItemId 12 | Where-Object Action -eq 'EDIT PERMISSIONS' | Sort-Object DateRecorded -Descending | Select-Object -First 1
    Get-TssExternalVaultSecretPermissionHistory -TssSession $session -Id 12 -AuditId $change.AuditId

    Get the permission records of the latest permission change on external vault secret 12

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Get-TssExternalVaultSecretPermissionHistory

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Get-TssExternalVaultSecretPermissionHistory.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.ExternalVaults.SecretPermissionHistory[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ExternalVaultSecretId')]
        [int[]]
        $Id,

        [Parameter(Mandatory)]
        [int]
        $AuditId
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
                $uri = $TssSession.ApiUrl, 'external-vaults', 'vaults', 'secrets', $currentId, 'permission-history' -join '/'
                $queryParams = @()
                $queryParams += "take=$($TssSession.Take)"
                switch ($tssParams.Keys) {
                    'AuditId' {
                        $queryParams += "filter.auditId=$($AuditId)"
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
                    Write-Warning 'Issue with Get-TssExternalVaultSecretPermissionHistory request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.records) {
                    [Thycotic.PowerShell.ExternalVaults.SecretPermissionHistory[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.ExternalVaults.SecretPermissionHistory]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
