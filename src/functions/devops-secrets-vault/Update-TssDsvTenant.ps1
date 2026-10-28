function Update-TssDsvTenant {
    <#
    .SYNOPSIS
    Update a DevOps Secrets Vault tenant

    .DESCRIPTION
    Updates an existing DevOps Secrets Vault tenant. The server validates the secret, tenant name and sync interval on every update, so all three are required. Pipe the tenant from Get-TssDsvTenant to keep the values you do not change.
    -Active changes the state of the tenant only when it is passed.
    The secret must hold the Client ID, Client Secret and Tenant fields of the DevOps Secrets Vault Client Credentials template, and a secret can back only one tenant.
    Returns the updated tenant.
    Requires a DevOps Secrets Vault license and an administrator.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    DevOps Secrets Vault tenant id

    .PARAMETER Active
    Activate the tenant, or pass -Active:$false to deactivate it

    .PARAMETER SecretId
    Id of the secret that holds the DSV client credentials of the tenant

    .PARAMETER SyncInterval
    Sync interval of the tenant in minutes (at least 10 on-premises, 30 on Secret Server Cloud)

    .PARAMETER TenantName
    DevOps Secrets Vault tenant name

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDsvTenant -TssSession $session -Id 1 | Update-TssDsvTenant -TssSession $session -SyncInterval 120

    Change the sync interval of DSV tenant 1 and keep its other settings

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssDsvTenant -TssSession $session -Id 1 -TenantName contoso -SecretId 42 -SyncInterval 60 -Active:$false

    Set every setting of DSV tenant 1 and deactivate it

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/devops-secrets-vault/Update-TssDsvTenant

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/devops-secrets-vault/Update-TssDsvTenant.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.DevOpsSecretsVault.DsvTenant')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('DsvTenantId')]
        [int]
        $Id,

        [Parameter(ValueFromPipelineByPropertyName)]
        [switch]
        $Active,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $SecretId,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $SyncInterval,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]
        $TenantName
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'devops-secrets-vault', 'tenant', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $body = @{
                data = @{
                    secretId     = @{ dirty = $true; value = $SecretId }
                    tenantName   = @{ dirty = $true; value = $TenantName }
                    syncInterval = @{ dirty = $true; value = $SyncInterval }
                    active       = @{ dirty = $tssParams.ContainsKey('Active'); value = [boolean]$Active }
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Dsv tenant: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssDsvTenant request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.DevOpsSecretsVault.DsvTenant](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DevOpsSecretsVault.DsvTenant]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
