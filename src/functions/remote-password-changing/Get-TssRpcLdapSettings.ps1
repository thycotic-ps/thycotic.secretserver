function Get-TssRpcLdapSettings {
    <#
    .SYNOPSIS
    Get the LDAP connection settings for a password type

    .DESCRIPTION
    Get the LDAP connection settings that an LDAP password type (for example LDAP (Active Directory) or LDAP (OpenLDAP)) uses to change passwords.
    The ID is the LDAP connection settings ID, not the password type ID: read it from the LdapConnectionSettingsId property of Get-TssRpcPasswordType output.
    An ID that is not an LDAP connection settings ID returns a server error.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    LDAP connection settings ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssRpcLdapSettings -TssSession $session -Id 2

    Get LDAP connection settings 2

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssRpcPasswordType -TssSession $session -Id 21 | Get-TssRpcLdapSettings -TssSession $session

    Get the LDAP connection settings used by password type 21

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Get-TssRpcLdapSettings

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Get-TssRpcLdapSettings.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Rpc.LdapSettings')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('LdapConnectionSettingsId')]
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
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'remote-password-changing', 'ldap-settings', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssRpcLdapSettings request'
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
