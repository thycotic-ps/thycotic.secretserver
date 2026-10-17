function Set-TssSecretPlatformPermission {
    <#
    .SYNOPSIS
    Grant a platform service account a role on a secret

    .DESCRIPTION
    Grant a platform service account a secret access role on a secret. Nothing changes when the account already has the role.
    Success is false, with the reason in Message, when the account is not a platform service account (always so on a Secret Server not connected to the Delinea Platform).
    Success is false and Message is empty when the secret needs check out, double lock, a comment or approval for access, or when the grant fails.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER SecretId
    Secret ID

    .PARAMETER Username
    Username of the platform service account

    .PARAMETER AccessRole
    Secret access role to grant (List, View, Edit, Owner)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSecretPlatformPermission -TssSession $session -SecretId 42 -Username svc-reporting -AccessRole View

    Grants platform service account svc-reporting View on secret 42

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSecretPlatformPermission -TssSession $session -SecretId 42 -Username svc-reporting -AccessRole Edit -WhatIf

    Shows the request that would grant Edit without sending it

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-permissions/Set-TssSecretPlatformPermission

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-permissions/Set-TssSecretPlatformPermission.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SecretPermissions.PlatformPermission')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $SecretId,

        [Parameter(Mandatory)]
        [Alias('PlatformUserName')]
        [string]
        $Username,

        [Parameter(Mandatory)]
        [Alias('AclRoleName')]
        [Thycotic.PowerShell.Enums.SecretPermissions]
        $AccessRole
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secret-permissions', 'platform-permission' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ }
            switch ($tssParams.Keys) {
                'SecretId' {
                    $body.Add('secretId', $SecretId)
                }
                'Username' {
                    $body.Add('userName', $Username)
                }
                'AccessRole' {
                    $body.Add('aclRoleName', [string]$AccessRole)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Secret ID: $SecretId","$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssSecretPlatformPermission request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.SecretPermissions.PlatformPermission](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SecretPermissions.PlatformPermission]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
