function New-TssActiveDirectoryDomain {
    <#
    .SYNOPSIS
    Create a directory domain through the legacy Active Directory endpoint

    .DESCRIPTION
    Create an Active Directory, Azure AD or OpenLDAP domain through the legacy active-directory endpoint. New-TssDirectoryService creates the same domain through the directory-services endpoint and is the preferred cmdlet.
    An active domain is validated against the directory with the synchronization secret (Azure AD: tenant, client ID and secret); create it inactive to skip that check and activate it later with Set-TssDirectoryDomain. The response never includes the domain password, and it reports AuthType Anonymous whatever was sent: the server stores the value you pass.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER DomainType
    Directory type: ActiveDirectory, OpenLdap or AzureActiveDirectory

    .PARAMETER DomainName
    Fully qualified domain name

    .PARAMETER FriendlyName
    Friendly (short) domain name, used in Discovery matching

    .PARAMETER Active
    Create the domain active; Secret Server then validates it against the directory

    .PARAMETER SiteId
    Site whose engines reach the directory, default 1 (the local site)

    .PARAMETER SecretId
    Secret used to read the directory during synchronization

    .PARAMETER UseSecureLdap
    Use LDAPS

    .PARAMETER MfaProvider
    Multifactor authentication provider for users of the domain, default None

    .PARAMETER DistinguishedName
    Distinguished name (OpenLDAP)

    .PARAMETER AuthType
    Bind authentication type (OpenLDAP): Basic, Anonymous or Kerberos

    .PARAMETER UserAuthType
    User authentication type (OpenLDAP): Basic, Kerberos or NoAuthentication

    .PARAMETER TenantId
    Azure AD tenant ID

    .PARAMETER ClientId
    Azure AD application client ID

    .PARAMETER ClientSecret
    Azure AD application client secret; never shown in Verbose or WhatIf output

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssActiveDirectoryDomain -TssSession $session -DomainType ActiveDirectory -DomainName corp.example.com -FriendlyName CORP -SecretId 42 -Active

    Create an active Active Directory domain that synchronizes with secret 42

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssActiveDirectoryDomain -TssSession $session -DomainType OpenLdap -DomainName ldap.example.com -FriendlyName LDAP -DistinguishedName 'DC=ldap,DC=example,DC=com' -AuthType Basic -SecretId 43

    Create an inactive OpenLDAP domain

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/active-directory/New-TssActiveDirectoryDomain

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/active-directory/New-TssActiveDirectoryDomain.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    Secret Server marks this endpoint obsolete in favor of the directory-services endpoints; it still answers on current versions.
    Requires the Administer Active Directory permission.
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.ActiveDirectory.Domain')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [ValidateSet('ActiveDirectory', 'OpenLdap', 'AzureActiveDirectory')]
        [string]
        $DomainType,

        [Parameter(Mandatory)]
        [string]
        $DomainName,

        [string]
        $FriendlyName,

        [switch]
        $Active,

        [int]
        $SiteId = 1,

        [Alias('SyncSecretId')]
        [int]
        $SecretId,

        [switch]
        $UseSecureLdap,

        [ValidateSet('None', 'Radius', 'TOTPAuthenticator', 'Duo', 'Fido2', 'Email')]
        [string]
        $MfaProvider = 'None',

        [string]
        $DistinguishedName,

        [Thycotic.PowerShell.Enums.LdapAuthType]
        $AuthType,

        [Thycotic.PowerShell.Enums.UserAuthType]
        $UserAuthType,

        [guid]
        $TenantId,

        [guid]
        $ClientId,

        [securestring]
        $ClientSecret
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'active-directory', 'domains' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{
                domainType                  = $DomainType
                domainName                  = $DomainName
                active                      = [boolean]$Active
                siteId                      = $SiteId
                requireRadiusAuthentication = $MfaProvider -eq 'Radius'
                requireOATHAuthentication   = $MfaProvider -eq 'TOTPAuthenticator'
                requireDuoAuthentication    = $MfaProvider -eq 'Duo'
                requireFido2Authentication  = $MfaProvider -eq 'Fido2'
                requireEmailAuthentication  = $MfaProvider -eq 'Email'
            }
            switch ($tssParams.Keys) {
                'FriendlyName' { $body.Add('friendlyName', $FriendlyName) }
                'SecretId' { $body.Add('syncSecretId', $SecretId) }
                'UseSecureLdap' { $body.Add('useSecureLDAP', [boolean]$UseSecureLdap) }
                'DistinguishedName' { $body.Add('distinguishedName', $DistinguishedName) }
                'AuthType' { $body.Add('authType', [string]$AuthType) }
                'UserAuthType' { $body.Add('userAuthType', $(if ($UserAuthType -eq 'NoAuthentication') { $null } else { [string]$UserAuthType })) }
                'TenantId' { $body.Add('tenantId', $TenantId.ToString()) }
                'ClientId' { $body.Add('clientId', $ClientId.ToString()) }
            }
            $requestText = "with:`n$($body | ConvertTo-Json -Depth 100)`n"
            if ($tssParams.ContainsKey('ClientSecret')) {
                $body.Add('clientSecret', [System.Net.NetworkCredential]::new('', $ClientSecret).Password)
                $requestText = '(request body not shown: it carries sensitive values)'
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Directory domain: $DomainName", "$($invokeParams.Method) $uri $requestText")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri $requestText"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssActiveDirectoryDomain request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.ActiveDirectory.Domain](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.ActiveDirectory.Domain]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
