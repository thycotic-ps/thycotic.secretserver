function New-TssDsvTenant {
    <#
    .SYNOPSIS
    Create a DevOps Secrets Vault tenant

    .DESCRIPTION
    Creates a DevOps Secrets Vault (DSV) tenant that ties a secret holding DSV client credentials to a DSV tenant name and a sync interval. Secrets are then pushed to the tenant with Add-TssDsvSync.
    Use -Active to create the tenant active. Without -Active the tenant is created inactive.
    The secret must hold the Client ID, Client Secret and Tenant fields of the DevOps Secrets Vault Client Credentials template, and a secret can back only one tenant.
    Returns the created tenant.
    Requires a DevOps Secrets Vault license and an administrator.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Active
    Create the tenant active. Omit to create it inactive

    .PARAMETER SecretId
    Id of the secret that holds the DSV client credentials of the tenant

    .PARAMETER SyncInterval
    Sync interval of the tenant in minutes (at least 10 on-premises, 30 on Secret Server Cloud)

    .PARAMETER TenantName
    DevOps Secrets Vault tenant name

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssDsvTenant -TssSession $session -TenantName contoso -SecretId 42 -SyncInterval 60 -Active

    Create an active DSV tenant contoso whose client credentials are in secret 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/devops-secrets-vault/New-TssDsvTenant

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/devops-secrets-vault/New-TssDsvTenant.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.DevOpsSecretsVault.DsvTenant')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $Active,

        [Parameter(Mandatory)]
        [int]
        $SecretId,

        [Parameter(Mandatory)]
        [int]
        $SyncInterval,

        [Parameter(Mandatory)]
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
            $uri = $TssSession.ApiUrl, 'devops-secrets-vault', 'tenant' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{
                data = @{
                    secretId     = @{ dirty = $true; value = $SecretId }
                    tenantName   = @{ dirty = $true; value = $TenantName }
                    syncInterval = @{ dirty = $true; value = $SyncInterval }
                    active       = @{ dirty = $true; value = [boolean]$Active }
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Dsv tenant", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssDsvTenant request'
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
