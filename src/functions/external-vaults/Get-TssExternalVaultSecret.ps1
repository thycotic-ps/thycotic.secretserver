function Get-TssExternalVaultSecret {
    <#
    .SYNOPSIS
    Get an external vault secret

    .DESCRIPTION
    Get an external vault secret by ID. An external vault secret links a Secret Server secret to a secret in an external vault (Azure Key Vault, AWS Secrets Manager, Google Secret Manager or HashiCorp Vault).
    The output carries the link, the transform or mappings, the last push result and the caller permissions. It does not carry the secret value; use Get-TssExternalVaultSecretRemoteValue for that.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    External vault secret ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssExternalVaultSecret -TssSession $session -Id 12

    Get external vault secret 12

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Get-TssExternalVaultSecret

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Get-TssExternalVaultSecret.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.ExternalVaults.Secret')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ExternalVaultSecretId')]
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
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'external-vaults', 'vaults', 'secrets', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssExternalVaultSecret request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.ExternalVaults.Secret](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.ExternalVaults.Secret]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
