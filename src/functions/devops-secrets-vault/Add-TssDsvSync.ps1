function Add-TssDsvSync {
    <#
    .SYNOPSIS
    Create a sync between a secret and a DevOps Secrets Vault tenant

    .DESCRIPTION
    Creates a sync map that pushes a secret to a DevOps Secrets Vault (DSV) tenant at the given DSV path.
    Use -Active to create the map active, which also queues an initial sync. Without -Active the map is created inactive and is not synced until it is activated with Update-TssDsvSync.
    Returns the sync status of the new map. Its DevOpsSyncMapId is the id used by Get-TssDsvSyncStatus, Update-TssDsvSync and Invoke-TssDsvSync.
    Requires a DevOps Secrets Vault license and an administrator.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Active
    Create the sync map active and queue an initial sync. Omit to create it inactive

    .PARAMETER DsvTenantId
    Id of the DevOps Secrets Vault tenant the secret is pushed to (see Search-TssDsvTenant)

    .PARAMETER FieldNamesPath
    Path segments in DevOps Secrets Vault where the secret is stored. Omit to send an empty path

    .PARAMETER SecretId
    Id of the secret to push to DevOps Secrets Vault

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Add-TssDsvSync -TssSession $session -SecretId 42 -DsvTenantId 1 -FieldNamesPath apps, billing -Active

    Push secret 42 to DSV tenant 1 under the path apps/billing and queue the first sync

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Add-TssDsvSync -TssSession $session -SecretId 42 -DsvTenantId 1 -FieldNamesPath staging

    Create an inactive sync map for secret 42 that is not synced until activated

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/devops-secrets-vault/Add-TssDsvSync

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/devops-secrets-vault/Add-TssDsvSync.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.DevOpsSecretsVault.DsvSync')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $Active,

        [Parameter(Mandatory)]
        [int]
        $DsvTenantId,

        [string[]]
        $FieldNamesPath = @(),

        [Parameter(Mandatory)]
        [int]
        $SecretId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'devops-secrets-vault', 'add-sync' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{
                data = @{
                    secretId       = @{ dirty = $true; value = $SecretId }
                    dsvTenantId    = @{ dirty = $true; value = $DsvTenantId }
                    active         = @{ dirty = $true; value = [boolean]$Active }
                    fieldNamesPath = @{ dirty = $true; value = $FieldNamesPath }
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Dsv sync", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Add-TssDsvSync request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.DevOpsSecretsVault.DsvSync](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DevOpsSecretsVault.DsvSync]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
