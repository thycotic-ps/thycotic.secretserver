function Get-TssSecretPermissionRoleOption {
    <#
    .SYNOPSIS
    Get the roles that can be granted on a secret

    .DESCRIPTION
    Get the secret access roles (List, View, Edit, Owner) that can be granted on a secret, and which one is the default.
    One object is returned per role.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretPermissionRoleOption -TssSession $session

    Returns every secret access role

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretPermissionRoleOption -TssSession $session | Where-Object IsDefault

    Returns the default secret access role

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-permissions/Get-TssSecretPermissionRoleOption

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-permissions/Get-TssSecretPermissionRoleOption.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SecretPermissions.RoleOption[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secret-permissions', 'role-options' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssSecretPermissionRoleOption request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.roleOptions) {
                [Thycotic.PowerShell.SecretPermissions.RoleOption[]](. $FilterTssResponse $restResponse.roleOptions ([Thycotic.PowerShell.SecretPermissions.RoleOption]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
