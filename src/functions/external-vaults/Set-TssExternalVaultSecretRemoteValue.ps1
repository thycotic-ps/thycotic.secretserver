function Set-TssExternalVaultSecretRemoteValue {
    <#
    .SYNOPSIS
    Set the value of an external vault secret in the external vault

    .DESCRIPTION
    Connect to the external vault (Azure Key Vault, AWS Secrets Manager, Google Secret Manager or HashiCorp Vault) and write a value to it for an external vault secret.
    Single mode bindings take -Value. Key/value map bindings take -Entries, one key per configured remote key. The server rejects the wrong shape for the binding.
    The request body is never written to Verbose or WhatIf output.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    External vault secret ID

    .PARAMETER Entries
    Key/value pairs to write, for key/value map bindings: each key is a configured remote key, each value a string or SecureString

    .PARAMETER Value
    Value to write, for single mode bindings

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssExternalVaultSecretRemoteValue -TssSession $session -Id 12 -Value (Read-Host -AsSecureString)

    Write a new value to the external vault for single mode external vault secret 12

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $newValue = Read-Host -AsSecureString
    Set-TssExternalVaultSecretRemoteValue -TssSession $session -Id 13 -Entries @{ username = 'svc-app'; credential = $newValue }

    Write the username and credential keys to the external vault for key/value map external vault secret 13

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Set-TssExternalVaultSecretRemoteValue

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Set-TssExternalVaultSecretRemoteValue.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.ExternalVaults.SecretRemoteValue')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ExternalVaultSecretId')]
        [int]
        $Id,

        [Parameter(Mandatory, ParameterSetName = 'Entries')]
        [hashtable]
        $Entries,

        [Parameter(Mandatory, ParameterSetName = 'Value')]
        [securestring]
        $Value
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.7.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'external-vaults', 'vaults', 'secrets', $Id, 'remote-value' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($PSCmdlet.ParameterSetName) {
                'Entries' {
                    $remoteEntries = @{ }
                    foreach ($entryKey in $Entries.Keys) {
                        $entryValue = $Entries[$entryKey]
                        if ($entryValue -is [securestring]) {
                            $entryValue = [System.Net.NetworkCredential]::new('', $entryValue).Password
                        }
                        $remoteEntries[[string]$entryKey] = [string]$entryValue
                    }
                    $body.data.Add('entries', $remoteEntries)
                }
                'Value' {
                    $body.data.Add('value', [System.Net.NetworkCredential]::new('', $Value).Password)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("External vault secret remote value: $Id", "$($invokeParams.Method) $uri (request body not shown: it carries sensitive values)")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri (request body not shown: it carries sensitive values)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssExternalVaultSecretRemoteValue request'
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
