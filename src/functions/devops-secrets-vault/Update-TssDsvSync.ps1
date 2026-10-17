function Update-TssDsvSync {
    <#
    .SYNOPSIS
    Update a sync between a secret and a DevOps Secrets Vault tenant

    .DESCRIPTION
    Updates an existing DevOps Secrets Vault sync map. Only the parameters you pass are changed.
    Returns the sync status of the updated map.
    Requires a DevOps Secrets Vault license and an administrator.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Sync map id (DevOpsSyncMapId)

    .PARAMETER Active
    Activate the sync map, or pass -Active:$false to deactivate it

    .PARAMETER DsvTenantId
    Id of the DevOps Secrets Vault tenant the secret is pushed to

    .PARAMETER FieldNamesPath
    Path segments in DevOps Secrets Vault where the secret is stored

    .PARAMETER SecretId
    Id of the secret the sync map pushes

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssDsvSync -TssSession $session -Id 3 -Active:$false

    Deactivate sync map 3

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssDsvSync -TssSession $session -Id 3 -FieldNamesPath apps, billing, prod

    Move the DSV path of sync map 3 to apps/billing/prod

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/devops-secrets-vault/Update-TssDsvSync

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/devops-secrets-vault/Update-TssDsvSync.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.DevOpsSecretsVault.DsvSync')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('DevOpsSyncMapId', 'SyncMapId')]
        [int]
        $Id,

        [switch]
        $Active,

        [int]
        $DsvTenantId,

        [string[]]
        $FieldNamesPath = @(),

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
            $uri = $TssSession.ApiUrl, 'devops-secrets-vault', 'sync', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $body = @{
                data = @{
                    secretId       = @{ dirty = $tssParams.ContainsKey('SecretId'); value = $SecretId }
                    dsvTenantId    = @{ dirty = $tssParams.ContainsKey('DsvTenantId'); value = $DsvTenantId }
                    active         = @{ dirty = $tssParams.ContainsKey('Active'); value = [boolean]$Active }
                    fieldNamesPath = @{ dirty = $tssParams.ContainsKey('FieldNamesPath'); value = $FieldNamesPath }
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Dsv sync: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssDsvSync request'
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
