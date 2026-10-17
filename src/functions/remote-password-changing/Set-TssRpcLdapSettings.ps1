function Set-TssRpcLdapSettings {
    <#
    .SYNOPSIS
    Update the LDAP settings for an RPC password type

    .DESCRIPTION
    Update the LDAP connection settings that an LDAP password type (for example LDAP (Active Directory) or LDAP (OpenLDAP)) uses to change passwords.
    Only the parameters you pass are changed; the others keep their stored value.
    Switch parameters send true when present; pass for example -SecureSocketLayer:$false to turn a setting off.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    LDAP connection settings ID (the LdapConnectionSettingsId property of Get-TssRpcPasswordType output)

    .PARAMETER AuthType
    The authentication mechanism to use when connecting to the LDAP server. "Basic" by default

    .PARAMETER ConvertUserToDistinguishedName
    Check this to use the "User Distinguished Name Format" to determine the Distinguished Name

    .PARAMETER LookupDistinguishedNameForConnection
    Use distinguished name for connection (Requires anonymous authentication and searching enabled on the domain.)

    .PARAMETER LookupDistinguishedNameForReset
    Use distinguished name for reset

    .PARAMETER PasswordAttribute
    By default this is "userpassword" for Open LDAP or "unicodePwd" for Active Directory, but any attribute can be entered here

    .PARAMETER PasswordEncodingType
    Determines whether passwords are encoded for Open LDAP or Active Directory

    .PARAMETER ProtocolVersion
    The version of the LDAP protocol to use, 3 by default

    .PARAMETER SecureSocketLayer
    Use SSL

    .PARAMETER UserDistinguishedNameFormat
    Ex. (uid=$USERNAME,CN=Users,$DISTINGUISHEDDOMAINNAME). Useful if all users are in a single location

    .PARAMETER UserNameAuthenticationFormat
    Ex. $USERNAME@$DOMAIN

    .PARAMETER UserSearchFormat
    Ex. (uid=$USERNAME) or (cn=$USERNAME)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssRpcLdapSettings -TssSession $session -Id 2 -SecureSocketLayer -ProtocolVersion 3

    Turn on SSL and LDAP protocol version 3 for LDAP connection settings 2

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssRpcPasswordType -TssSession $session -Id 20 | Set-TssRpcLdapSettings -TssSession $session -UserSearchFormat '(uid=$USERNAME)'

    Change the user search filter of the LDAP settings used by password type 20

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Set-TssRpcLdapSettings

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Set-TssRpcLdapSettings.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUsernameAndPasswordParams', '', Justification = 'Setting names from the REST model, not a credential pair')]
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Rpc.LdapSettings')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('LdapConnectionSettingsId')]
        [int]
        $Id,

        [ValidateSet('Anonymous', 'Basic', 'Negotiate', 'Ntlm', 'Digest', 'Sicily', 'Dpa', 'Msn', 'External', 'Kerberos')]
        [string]
        $AuthType,

        [switch]
        $ConvertUserToDistinguishedName,

        [switch]
        $LookupDistinguishedNameForConnection,

        [switch]
        $LookupDistinguishedNameForReset,

        [string]
        $PasswordAttribute,

        [ValidateSet('OpenLdap', 'ActiveDirectory')]
        [string]
        $PasswordEncodingType,

        [int]
        $ProtocolVersion,

        [switch]
        $SecureSocketLayer,

        [string]
        $UserDistinguishedNameFormat,

        [string]
        $UserNameAuthenticationFormat,

        [string]
        $UserSearchFormat
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'remote-password-changing', 'ldap-settings', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'AuthType' {
                    $body.data.Add('authType', @{ dirty = $true; value = $AuthType })
                }
                'ConvertUserToDistinguishedName' {
                    $body.data.Add('convertUserToDistinguishedName', @{ dirty = $true; value = [boolean]$ConvertUserToDistinguishedName })
                }
                'LookupDistinguishedNameForConnection' {
                    $body.data.Add('lookupDistinguishedNameForConnection', @{ dirty = $true; value = [boolean]$LookupDistinguishedNameForConnection })
                }
                'LookupDistinguishedNameForReset' {
                    $body.data.Add('lookupDistinguishedNameForReset', @{ dirty = $true; value = [boolean]$LookupDistinguishedNameForReset })
                }
                'PasswordAttribute' {
                    $body.data.Add('passwordAttribute', @{ dirty = $true; value = $PasswordAttribute })
                }
                'PasswordEncodingType' {
                    $body.data.Add('passwordEncodingType', @{ dirty = $true; value = $PasswordEncodingType })
                }
                'ProtocolVersion' {
                    $body.data.Add('protocolVersion', @{ dirty = $true; value = $ProtocolVersion })
                }
                'SecureSocketLayer' {
                    $body.data.Add('secureSocketLayer', @{ dirty = $true; value = [boolean]$SecureSocketLayer })
                }
                'UserDistinguishedNameFormat' {
                    $body.data.Add('userDistinguishedNameFormat', @{ dirty = $true; value = $UserDistinguishedNameFormat })
                }
                'UserNameAuthenticationFormat' {
                    $body.data.Add('userNameAuthenticationFormat', @{ dirty = $true; value = $UserNameAuthenticationFormat })
                }
                'UserSearchFormat' {
                    $body.data.Add('userSearchFormat', @{ dirty = $true; value = $UserSearchFormat })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Rpc ldap settings: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssRpcLdapSettings request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Rpc.LdapSettings](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Rpc.LdapSettings]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
