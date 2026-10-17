function Set-TssExternalVaultBulk {
    <#
    .SYNOPSIS
    Update several external vaults at once

    .DESCRIPTION
    Applies the same changes to every external vault id passed in one request. Only the parameters you pass are changed.
    Returns one result per vault, with the updated vault or the error for that vault.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Active
    Activate the external vaults, or pass -Active:$false to deactivate them

    .PARAMETER CredentialSecretId
    Id of the secret that holds the credentials of the external vaults

    .PARAMETER DisplayName
    Display name of the external vaults

    .PARAMETER HashiCorpSkipCertificateValidation
    Skip TLS certificate validation when connecting to HashiCorp Vault, or pass -HashiCorpSkipCertificateValidation:$false to validate certificates (HashiCorp Vault only)

    .PARAMETER SecretRegex
    Regular expression that limits which external secrets are listed

    .PARAMETER SiteId
    Distributed engine site used to reach the external vaults

    .PARAMETER Id
    Ids of the external vaults to update

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssExternalVaultBulk -TssSession $session -Id 2, 3, 4 -Active:$false

    Deactivate external vaults 2, 3 and 4

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssExternalVaultBulk -TssSession $session -Id 2, 3 -CredentialSecretId 44 -SiteId 1

    Point external vaults 2 and 3 at the credentials in secret 44, reached through site 1

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Set-TssExternalVaultBulk

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Set-TssExternalVaultBulk.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.ExternalVaults.Bulk')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $Active,

        [int]
        $CredentialSecretId,

        [string]
        $DisplayName,

        [switch]
        $HashiCorpSkipCertificateValidation,

        [string]
        $SecretRegex,

        [int]
        $SiteId,

        [Parameter(Mandatory)]
        [Alias('ExternalVaultId')]
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
            Compare-TssVersion $TssSession '11.7.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'external-vaults', 'vaults', 'bulk-update' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Active' {
                    $body.data.Add('active', @{ dirty = $true; value = [boolean]$Active })
                }
                'CredentialSecretId' {
                    $body.data.Add('credentialSecretId', @{ dirty = $true; value = $CredentialSecretId })
                }
                'DisplayName' {
                    $body.data.Add('displayName', @{ dirty = $true; value = $DisplayName })
                }
                'HashiCorpSkipCertificateValidation' {
                    $body.data.Add('hashiCorpConnectionParameters', @{ skipCertificateValidation = @{ dirty = $true; value = [boolean]$HashiCorpSkipCertificateValidation } })
                }
                'SecretRegex' {
                    $body.data.Add('secretRegex', @{ dirty = $true; value = $SecretRegex })
                }
                'SiteId' {
                    $body.data.Add('siteId', @{ dirty = $true; value = $SiteId })
                }
                'Id' {
                    $body.Add('externalVaultIds', $Id)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("External vault bulk", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssExternalVaultBulk request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.ExternalVaults.Bulk](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.ExternalVaults.Bulk]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
