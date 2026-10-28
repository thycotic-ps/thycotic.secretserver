function Get-TssExternalVaultSecretRemoteValue {
    <#
    .SYNOPSIS
    Get the value of an external vault secret from the external vault

    .DESCRIPTION
    Connect to the external vault (Azure Key Vault, AWS Secrets Manager, Google Secret Manager or HashiCorp Vault) and read the value currently stored there for an external vault secret.
    The output carries the secret value in plain text: Value for single mode bindings, Entries for key/value map bindings.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    External vault secret ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssExternalVaultSecretRemoteValue -TssSession $session -Id 12

    Get the value stored in the external vault for external vault secret 12

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Get-TssExternalVaultSecretRemoteValue

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Get-TssExternalVaultSecretRemoteValue.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.ExternalVaults.SecretRemoteValue')]
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
                $uri = $TssSession.ApiUrl, 'external-vaults', 'vaults', 'secrets', $currentId, 'remote-value' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssExternalVaultSecretRemoteValue request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.ExternalVaults.SecretRemoteValue](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.ExternalVaults.SecretRemoteValue]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
