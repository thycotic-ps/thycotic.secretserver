function Invoke-TssDsvSync {
    <#
    .SYNOPSIS
    Sync secrets to DevOps Secrets Vault now

    .DESCRIPTION
    Queues an immediate sync for one or more DevOps Secrets Vault sync maps. Each active map is pushed to its DSV tenant; inactive maps are returned unchanged and are not synced.
    Takes sync map ids (DevOpsSyncMapId), not secret ids. The server rejects the request when none of the ids is a sync map.
    Returns one sync status per map.
    Requires a DevOps Secrets Vault license and an administrator.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Sync map ids to sync now (DevOpsSyncMapId from Add-TssDsvSync or Get-TssDsvSyncStatus)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Invoke-TssDsvSync -TssSession $session -Id 3, 4

    Queue an immediate sync for sync maps 3 and 4

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDsvSyncStatus -TssSession $session -SecretId 42 | Invoke-TssDsvSync -TssSession $session

    Queue an immediate sync for every active sync map of secret 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/devops-secrets-vault/Invoke-TssDsvSync

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/devops-secrets-vault/Invoke-TssDsvSync.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DevOpsSecretsVault.DsvSync[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
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
            $uri = $TssSession.ApiUrl, 'devops-secrets-vault', 'sync' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ }
            switch ($tssParams.Keys) {
                'Id' {
                    $body.Add('data', $Id)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Invoke-TssDsvSync request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                foreach ($record in $restResponse) {
                    [Thycotic.PowerShell.DevOpsSecretsVault.DsvSync]@{
                        Active                = $record.active.value
                        DateAdded             = $record.dateAdded.value
                        DevOpsSecretVaultPath = $record.devOpsSecretVaultPath.value
                        DevOpsSyncMapId       = $record.devOpsSyncMapId.value
                        LastSyncTime          = $record.lastSyncTime.value
                        NextSyncTime          = $record.nextSyncTime.value
                        SecretId              = $record.secretId.value
                        SecretName            = $record.secretName.value
                        Status                = $record.status.value
                        TenantId              = $record.tenantId.value
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
