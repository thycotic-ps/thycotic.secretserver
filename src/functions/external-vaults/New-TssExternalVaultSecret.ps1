function New-TssExternalVaultSecret {
    <#
    .SYNOPSIS
    Create an external vault secret

    .DESCRIPTION
    Create an external vault secret: a secret in an external vault that Secret Server pushes the value of a linked secret to.
    Single mode bindings push the value built by -Transform. HashiCorp Vault bindings in key/value map mode push one key per -Mappings row.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Active
    Create the external vault secret as active. Omitted, it is created inactive

    .PARAMETER ExternalVaultId
    ID of the external vault that holds the secret

    .PARAMETER LinkedSecretId
    ID of the Secret Server secret to link

    .PARAMETER Mappings
    HashiCorp Vault key/value map bindings only: mapping rows, each a hashtable with remoteKey (key in the external vault) and transform (template evaluated at push time), for example @{ remoteKey = 'password'; transform = '$PASSWORD' }

    .PARAMETER Name
    Name of the secret in the external vault

    .PARAMETER Transform
    Template evaluated at push time to build the value sent to the external vault, for example '$PASSWORD'

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssExternalVaultSecret -TssSession $session -Name 'sql-prod-sa' -ExternalVaultId 3 -LinkedSecretId 42 -Transform '$PASSWORD' -Active

    Create an active external vault secret in external vault 3 that pushes the password of secret 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/New-TssExternalVaultSecret

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/New-TssExternalVaultSecret.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.ExternalVaults.Secret')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $Active,

        [Parameter(Mandatory)]
        [int]
        $ExternalVaultId,

        [int]
        $LinkedSecretId,

        [object[]]
        $Mappings,

        [Parameter(Mandatory)]
        [string]
        $Name,

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
            $uri = $TssSession.ApiUrl, 'external-vaults', 'secrets' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Active' {
                    $body.data.Add('active', [boolean]$Active)
                }
                'ExternalVaultId' {
                    $body.data.Add('externalVaultId', $ExternalVaultId)
                }
                'LinkedSecretId' {
                    $body.data.Add('linkedSecretId', $LinkedSecretId)
                }
                'Mappings' {
                    $body.data.Add('mappings', $Mappings)
                }
                'Name' {
                    $body.data.Add('name', $Name)
                }
                'Transform' {
                    $body.data.Add('transform', $Transform)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("External vault secret", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssExternalVaultSecret request'
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
