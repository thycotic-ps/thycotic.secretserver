function Get-TssDsvSyncStatus {
    <#
    .SYNOPSIS
    Get the DevOps Secrets Vault sync status of secrets

    .DESCRIPTION
    Without -Id, lists sync maps with their DSV path, status and last sync time, filtered by secret or tenant. Inactive maps are included only with -IncludeInactive.
    With -Id, gets one sync map, including its secret, tenant and next sync time.
    Requires a DevOps Secrets Vault license.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER IncludeInactive
    Include inactive sync maps

    .PARAMETER SecretId
    Only return sync maps of this secret id

    .PARAMETER TenantId
    Only return sync maps that push to this DevOps Secrets Vault tenant id

    .PARAMETER Id
    Sync map id (DevOpsSyncMapId)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDsvSyncStatus -TssSession $session -SecretId 42

    List the active sync maps of secret 42

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDsvSyncStatus -TssSession $session -TenantId 1 -IncludeInactive

    List every sync map that pushes to DSV tenant 1, inactive included

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDsvSyncStatus -TssSession $session -Id 3

    Get sync map 3

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/devops-secrets-vault/Get-TssDsvSyncStatus

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/devops-secrets-vault/Get-TssDsvSyncStatus.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'filter')]
    [OutputType('Thycotic.PowerShell.DevOpsSecretsVault.DsvSyncStatus[]', ParameterSetName = 'filter')]
    [OutputType('Thycotic.PowerShell.DevOpsSecretsVault.DsvSync', ParameterSetName = 'id')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(ParameterSetName = 'filter')]
        [switch]
        $IncludeInactive,

        [Parameter(ParameterSetName = 'filter')]
        [int]
        $SecretId,

        [Parameter(ParameterSetName = 'filter')]
        [int]
        $TenantId,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'id')]
        [Alias('DevOpsSyncMapId', 'SyncMapId')]
        [int[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            if ($PSCmdlet.ParameterSetName -eq 'id') {
                foreach ($currentId in $Id) {
                    $restResponse = $null
                    $uri = $TssSession.ApiUrl, 'devops-secrets-vault', 'sync', 'status', $currentId -join '/'
                    $invokeParams.Uri = $uri
                    $invokeParams.Method = 'GET'
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue with Get-TssDsvSyncStatus request'
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($restResponse) {
                        [Thycotic.PowerShell.DevOpsSecretsVault.DsvSync](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DevOpsSecretsVault.DsvSync]))
                    }
                }
            } else {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'devops-secrets-vault', 'sync', 'status' -join '/'
                $queryParams = @()
                $queryParams += "take=$($TssSession.Take)"
                switch ($tssParams.Keys) {
                    'IncludeInactive' {
                        $queryParams += "filter.includeInactive=$([boolean]$IncludeInactive)"
                    }
                    'SecretId' {
                        $queryParams += "filter.secretId=$($SecretId)"
                    }
                    'TenantId' {
                        $queryParams += "filter.tenantId=$($TenantId)"
                    }
                }
                $uri = $uri, ($queryParams -join '&') -join '?'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssDsvSyncStatus request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.records) {
                    [Thycotic.PowerShell.DevOpsSecretsVault.DsvSyncStatus[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.DevOpsSecretsVault.DsvSyncStatus]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
