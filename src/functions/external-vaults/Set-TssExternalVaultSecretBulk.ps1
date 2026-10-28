function Set-TssExternalVaultSecretBulk {
    <#
    .SYNOPSIS
    Set properties of several external vault secrets

    .DESCRIPTION
    Set the same properties on several external vault secrets in one request. Only the parameters passed are changed.
    The output lists one result per external vault secret, with the updated secret or the error.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Active
    Make the external vault secrets active (-Active) or inactive (-Active:$false)

    .PARAMETER EnableInheritPermissions
    Inherit permissions from the external vault (-EnableInheritPermissions) or not (-EnableInheritPermissions:$false)

    .PARAMETER LinkedSecretId
    ID of the Secret Server secret to link

    .PARAMETER Transform
    Template evaluated at push time to build the value sent to the external vault, for example '$PASSWORD'

    .PARAMETER ExternalVaultSecretId
    IDs of the external vault secrets to change

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssExternalVaultSecretBulk -TssSession $session -ExternalVaultSecretId 12, 13, 14 -Active:$false

    Make external vault secrets 12, 13 and 14 inactive

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Set-TssExternalVaultSecretBulk

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Set-TssExternalVaultSecretBulk.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.ExternalVaults.SecretBulk')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $Active,

        [switch]
        $EnableInheritPermissions,

        [int]
        $LinkedSecretId,

        [string]
        $Transform,

        [Parameter(Mandatory)]
        [int[]]
        $ExternalVaultSecretId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.7.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'external-vaults', 'vaults', 'secrets', 'bulk-update' -join '/'
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
                'Transform' {
                    $body.data.Add('transform', @{ dirty = $true; value = $Transform })
                }
                'ExternalVaultSecretId' {
                    $body.Add('externalVaultSecretIds', $ExternalVaultSecretId)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("External vault secret bulk", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssExternalVaultSecretBulk request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.ExternalVaults.SecretBulk](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.ExternalVaults.SecretBulk]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
