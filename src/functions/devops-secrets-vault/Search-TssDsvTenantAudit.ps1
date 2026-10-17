function Search-TssDsvTenantAudit {
    <#
    .SYNOPSIS
    Search DevOps Secrets Vault tenant audits

    .DESCRIPTION
    Lists the audit trail of changes made to DevOps Secrets Vault tenants, optionally filtered by tenant or text.
    Requires a DevOps Secrets Vault license.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER SearchText
    Only return audits matching this text

    .PARAMETER TenantId
    Only return audits of this DevOps Secrets Vault tenant id

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDsvTenantAudit -TssSession $session -TenantId 1

    List the audit trail of DSV tenant 1

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/devops-secrets-vault/Search-TssDsvTenantAudit

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/devops-secrets-vault/Search-TssDsvTenantAudit.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DevOpsSecretsVault.DsvTenantAudit[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [string]
        $SearchText,

        [int]
        $TenantId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'devops-secrets-vault', 'tenant', 'audits' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'SearchText' {
                    $queryParams += "filter.searchText=$([uri]::EscapeDataString($SearchText))"
                }
                'TenantId' {
                    $queryParams += "filter.tenantId=$($TenantId)"
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
                Write-Warning 'Issue with Search-TssDsvTenantAudit request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.DevOpsSecretsVault.DsvTenantAudit[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.DevOpsSecretsVault.DsvTenantAudit]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
