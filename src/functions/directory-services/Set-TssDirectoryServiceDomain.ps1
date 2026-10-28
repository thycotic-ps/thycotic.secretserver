function Set-TssDirectoryServiceDomain {
    <#
    .SYNOPSIS
    Update a Directory Services domain

    .DESCRIPTION
    Update a Directory Services domain (Active Directory, Azure AD or OpenLDAP). Only the parameters you pass are sent; use -Active:$false or -UseSecureLdap:$false to turn a setting off.
    The default parameter set calls the v1 endpoint, which also takes the Azure AD -TenantId, -ClientId and -ClientSecret. -V2 calls the v2 endpoint, which has no Azure AD credential fields.
    Activating a domain makes Secret Server validate it against the directory with the synchronization secret. Returns the updated domain.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Domain ID

    .PARAMETER Active
    Make the domain active (validated against the directory) or inactive

    .PARAMETER AuthType
    Bind authentication type (OpenLDAP): Basic, Anonymous or Kerberos

    .PARAMETER ClientId
    Azure AD application client ID (v1 only)

    .PARAMETER ClientSecret
    Azure AD application client secret (v1 only); never shown in Verbose or WhatIf output

    .PARAMETER DistinguishedName
    Distinguished name (OpenLDAP)

    .PARAMETER DomainName
    Fully qualified domain name

    .PARAMETER FriendlyName
    Friendly (short) domain name, used in Discovery matching

    .PARAMETER PreventNoUsersLockout
    Refuse a synchronization that would remove every user of the domain

    .PARAMETER MfaProvider
    Multifactor authentication provider for users of the domain

    .PARAMETER SiteId
    Site whose engines reach the directory

    .PARAMETER SecretId
    Secret used to read the directory during synchronization

    .PARAMETER TenantId
    Azure AD tenant ID (v1 only)

    .PARAMETER UserAuthType
    User authentication type (OpenLDAP): Basic, Kerberos, or NoAuthentication to clear it

    .PARAMETER UseSecureLdap
    Use LDAPS

    .PARAMETER V2
    Call the v2 endpoint

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDirectoryServiceDomain -TssSession $session -Id 3 -FriendlyName CORP

    Change the friendly name of domain 3

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDirectoryServiceDomain -TssSession $session -IncludeInactive | Where-Object DomainName -EQ corp.example.com | Set-TssDirectoryServiceDomain -TssSession $session -Active:$false

    Deactivate a domain found by name

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDirectoryServiceDomain -TssSession $session -Id 3 -SecretId 42 -V2

    Change the synchronization secret through the v2 endpoint

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Set-TssDirectoryServiceDomain

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Set-TssDirectoryServiceDomain.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Requires the Administer Active Directory permission.
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default', SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.DirectoryServices.DirectoryServiceDomain')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'Default')]
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'V2')]
        [Alias('DomainId')]
        [int]
        $Id,

        [Parameter(ParameterSetName = 'Default')]
        [Parameter(ParameterSetName = 'V2')]
        [switch]
        $Active,

        [Parameter(ParameterSetName = 'Default')]
        [Parameter(ParameterSetName = 'V2')]
        [Thycotic.PowerShell.Enums.LdapAuthType]
        $AuthType,

        [Parameter(ParameterSetName = 'Default')]
        [string]
        $ClientId,

        [Parameter(ParameterSetName = 'Default')]
        [securestring]
        $ClientSecret,

        [Parameter(ParameterSetName = 'Default')]
        [Parameter(ParameterSetName = 'V2')]
        [string]
        $DistinguishedName,

        [Parameter(ParameterSetName = 'Default')]
        [Parameter(ParameterSetName = 'V2')]
        [string]
        $DomainName,

        [Parameter(ParameterSetName = 'Default')]
        [Parameter(ParameterSetName = 'V2')]
        [string]
        $FriendlyName,

        [Parameter(ParameterSetName = 'Default')]
        [Parameter(ParameterSetName = 'V2')]
        [Alias('IsPreventNoUsersLockoutEnabled')]
        [switch]
        $PreventNoUsersLockout,

        [Parameter(ParameterSetName = 'Default')]
        [Parameter(ParameterSetName = 'V2')]
        [Alias('MultifactorAuthenticationProvider')]
        [ValidateSet('None', 'Radius', 'TOTPAuthenticator', 'Duo', 'Fido2', 'Email')]
        [string]
        $MfaProvider,

        [Parameter(ParameterSetName = 'Default')]
        [Parameter(ParameterSetName = 'V2')]
        [int]
        $SiteId,

        [Parameter(ParameterSetName = 'Default')]
        [Parameter(ParameterSetName = 'V2')]
        [Alias('SynchronizationSecretId')]
        [int]
        $SecretId,

        [Parameter(ParameterSetName = 'Default')]
        [string]
        $TenantId,

        [Parameter(ParameterSetName = 'Default')]
        [Parameter(ParameterSetName = 'V2')]
        [Thycotic.PowerShell.Enums.UserAuthType]
        $UserAuthType,

        [Parameter(ParameterSetName = 'Default')]
        [Parameter(ParameterSetName = 'V2')]
        [switch]
        $UseSecureLdap,

        [Parameter(Mandatory, ParameterSetName = 'V2')]
        [switch]
        $V2
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            switch ($PSCmdlet.ParameterSetName) {
                'V2' {
                    $uri = ($TssSession.ApiUrl -replace '/api/v1$','/api/v2'), 'directory-services', 'domains', $Id -join '/'
                    $body = @{ data = @{ } }
                    switch ($tssParams.Keys) {
                        'Active' {
                            $body.data.Add('active', @{ dirty = $true; value = [boolean]$Active })
                        }
                        'AuthType' {
                            $body.data.Add('authType', @{ dirty = $true; value = [string]$AuthType })
                        }
                        'DistinguishedName' {
                            $body.data.Add('distinguishedName', @{ dirty = $true; value = $DistinguishedName })
                        }
                        'DomainName' {
                            $body.data.Add('domainName', @{ dirty = $true; value = $DomainName })
                        }
                        'FriendlyName' {
                            $body.data.Add('friendlyName', @{ dirty = $true; value = $FriendlyName })
                        }
                        'PreventNoUsersLockout' {
                            $body.data.Add('isPreventNoUsersLockoutEnabled', @{ dirty = $true; value = [boolean]$PreventNoUsersLockout })
                        }
                        'MfaProvider' {
                            $body.data.Add('multifactorAuthenticationProvider', @{ dirty = $true; value = $MfaProvider })
                        }
                        'SiteId' {
                            $body.data.Add('siteId', @{ dirty = $true; value = $SiteId })
                        }
                        'SecretId' {
                            $body.data.Add('synchronizationSecretId', @{ dirty = $true; value = $SecretId })
                        }
                        'UserAuthType' {
                            $body.data.Add('userAuthType', @{ dirty = $true; value = if ($UserAuthType -eq 'NoAuthentication') { $null } else { [string]$UserAuthType } })
                        }
                        'UseSecureLdap' {
                            $body.data.Add('useSecureLDAP', @{ dirty = $true; value = [boolean]$UseSecureLdap })
                        }
                    }
                    $invokeParams.Body = $body | ConvertTo-Json -Depth 100
                }
                default {
                    $uri = $TssSession.ApiUrl, 'directory-services', 'domains', $Id -join '/'
                    $body = @{ data = @{ } }
                    switch ($tssParams.Keys) {
                        'Active' {
                            $body.data.Add('active', @{ dirty = $true; value = [boolean]$Active })
                        }
                        'AuthType' {
                            $body.data.Add('authType', @{ dirty = $true; value = [string]$AuthType })
                        }
                        'ClientId' {
                            $body.data.Add('clientId', @{ dirty = $true; value = $ClientId })
                        }
                        'ClientSecret' {
                            $body.data.Add('clientSecret', @{ dirty = $true; value = [System.Net.NetworkCredential]::new('', $ClientSecret).Password })
                        }
                        'DistinguishedName' {
                            $body.data.Add('distinguishedName', @{ dirty = $true; value = $DistinguishedName })
                        }
                        'DomainName' {
                            $body.data.Add('domainName', @{ dirty = $true; value = $DomainName })
                        }
                        'FriendlyName' {
                            $body.data.Add('friendlyName', @{ dirty = $true; value = $FriendlyName })
                        }
                        'PreventNoUsersLockout' {
                            $body.data.Add('isPreventNoUsersLockoutEnabled', @{ dirty = $true; value = [boolean]$PreventNoUsersLockout })
                        }
                        'MfaProvider' {
                            $body.data.Add('multifactorAuthenticationProvider', @{ dirty = $true; value = $MfaProvider })
                        }
                        'SiteId' {
                            $body.data.Add('siteId', @{ dirty = $true; value = $SiteId })
                        }
                        'SecretId' {
                            $body.data.Add('synchronizationSecretId', @{ dirty = $true; value = $SecretId })
                        }
                        'TenantId' {
                            $body.data.Add('tenantId', @{ dirty = $true; value = $TenantId })
                        }
                        'UserAuthType' {
                            $body.data.Add('userAuthType', @{ dirty = $true; value = if ($UserAuthType -eq 'NoAuthentication') { $null } else { [string]$UserAuthType } })
                        }
                        'UseSecureLdap' {
                            $body.data.Add('useSecureLDAP', @{ dirty = $true; value = [boolean]$UseSecureLdap })
                        }
                    }
                    $invokeParams.Body = $body | ConvertTo-Json -Depth 100
                }
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $requestText = if ($tssParams.ContainsKey('ClientSecret')) { '(request body not shown: it carries sensitive values)' } else { "with:`n$($invokeParams.Body)`n" }
            if ($PSCmdlet.ShouldProcess("Directory domain: $Id", "$($invokeParams.Method) $uri $requestText")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri $requestText"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssDirectoryServiceDomain request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.DirectoryServices.DirectoryServiceDomain](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DirectoryServices.DirectoryServiceDomain]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
