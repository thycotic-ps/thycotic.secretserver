function Set-TssExternalVaultSecret {
    <#
    .SYNOPSIS
    Set properties of an external vault secret

    .DESCRIPTION
    Set properties of an external vault secret. Only the parameters passed are changed.
    -Mappings replaces the mapping rows of a HashiCorp Vault key/value map binding: rows with an externalVaultSecretMappingId are updated, rows without one are added, and existing rows left out are deleted.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    External vault secret ID

    .PARAMETER Active
    Make the external vault secret active (-Active) or inactive (-Active:$false)

    .PARAMETER EnableInheritPermissions
    Inherit permissions from the external vault (-EnableInheritPermissions) or not (-EnableInheritPermissions:$false)

    .PARAMETER LinkedSecretId
    ID of the Secret Server secret to link

    .PARAMETER Mappings
    HashiCorp Vault key/value map bindings only: the full set of mapping rows, each a hashtable with remoteKey, transform and, for an existing row, externalVaultSecretMappingId

    .PARAMETER Transform
    Template evaluated at push time to build the value sent to the external vault, for example '$PASSWORD'

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssExternalVaultSecret -TssSession $session -Id 12 -Active:$false

    Make external vault secret 12 inactive

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssExternalVaultSecret -TssSession $session -Id 12 -Transform '$USERNAME:$PASSWORD'

    Change the transform of external vault secret 12

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Set-TssExternalVaultSecret

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Set-TssExternalVaultSecret.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.ExternalVaults.Secret')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ExternalVaultSecretId')]
        [int]
        $Id,

        [switch]
        $Active,

        [switch]
        $EnableInheritPermissions,

        [int]
        $LinkedSecretId,

        [object[]]
        $Mappings,

        [string]
        $Transform
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.7.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'external-vaults', 'vaults', 'secrets', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Active' {
                    $body.data.Add('active', @{ dirty = $true; value = [boolean]$Active })
                }
                'EnableInheritPermissions' {
                    $body.data.Add('enableInheritPermissions', @{ dirty = $true; value = [boolean]$EnableInheritPermissions })
                }
                'LinkedSecretId' {
                    $body.data.Add('linkedSecretId', @{ dirty = $true; value = $LinkedSecretId })
                }
                'Mappings' {
                    $body.data.Add('mappings', @{ dirty = $true; value = $Mappings })
                }
                'Transform' {
                    $body.data.Add('transform', @{ dirty = $true; value = $Transform })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("External vault secret: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssExternalVaultSecret request'
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
