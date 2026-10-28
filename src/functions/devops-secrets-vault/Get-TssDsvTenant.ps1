function Get-TssDsvTenant {
    <#
    .SYNOPSIS
    Get a DevOps Secrets Vault tenant

    .DESCRIPTION
    Gets a DevOps Secrets Vault (DSV) tenant: its name, the secret holding its client credentials, its sync interval and its last sync time.
    Requires a DevOps Secrets Vault license.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    DevOps Secrets Vault tenant id

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDsvTenant -TssSession $session -Id 1

    Get DSV tenant 1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDsvTenant -TssSession $session | Get-TssDsvTenant -TssSession $session

    Get every active DSV tenant

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/devops-secrets-vault/Get-TssDsvTenant

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/devops-secrets-vault/Get-TssDsvTenant.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DevOpsSecretsVault.DsvTenant')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('DsvTenantId')]
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
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'devops-secrets-vault', 'tenant', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssDsvTenant request'
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
