function New-TssDirectoryService {
    <#
    .SYNOPSIS
    Create a new Directory Service for Active Direcotry, AzureAD or OpenLDAP

    .DESCRIPTION
    Create a new Directory Service for Active Direcotry, AzureAD or OpenLDAP

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/New-TssDirectoryService

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/New-TssDirectoryService.ps1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $newDomain = @{
        TssSession = $session
        Active = $true
        DomainName = 'lab.local'
        FriendlyName = 'lab'
        SecretId = 1064
    }
    New-TssDirectoryService @newDomain

    Create a new Active Directory Domain Directory Service

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $newDomain = @{
        TssSession = $session
        Active = $true
        DomainName = 'lab.onmicrosoft.com'
        TenantId = '1dcfeb09-1600-4865-a4db-738ceab78d3d'
        ClientSecret = 'p857Q~fChrIsRkG0Pin3mUfHH3tAnp1W2RHOz'
        SecretId = 1064
    }
    New-TssDirectoryService @newDomain

    Create a new Azure Active Directory tenant Directory Service

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.DirectoryServices.Domain')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Active on creation
        [Parameter(ParameterSetName = 'active-directory')]
        [Parameter(ParameterSetName = 'azure')]
        [Parameter(ParameterSetName = 'openldap')]
        [switch]
        $Active,

        # Domain Name, FQDN
        [Parameter(Mandatory, ParameterSetName = 'active-directory')]
        [Parameter(Mandatory, ParameterSetName = 'azure')]
        [Parameter(Mandatory, ParameterSetName = 'openldap')]
        [string]
        $DomainName,

        # Domain Friendly Name (short name, will be used in Discovery matching)
        [Parameter(Mandatory, ParameterSetName = 'active-directory')]
        [Parameter(Mandatory, ParameterSetName = 'openldap')]
        [string]
        $FriendlyName,

        # Site ID, default local/default site (1)
        [Parameter(ParameterSetName = 'active-directory')]
        [Parameter(ParameterSetName = 'azure')]
        [Parameter(ParameterSetName = 'openldap')]
        [int]
        $SiteId = 1,

        # Use Secure LDAP
        [Parameter(ParameterSetName = 'active-directory')]
        [Parameter(ParameterSetName = 'openldap')]
        [switch]
        $UseSecureLdap,

        # MFA Provider, default None
        [Parameter(ParameterSetName = 'active-directory')]
        [Parameter(ParameterSetName = 'azure')]
        [Parameter(ParameterSetName = 'openldap')]
        [Thycotic.PowerShell.Enums.MfaProviderType]
        $MfaProvider = 'None',

        # Secret used for synchronization
        [Parameter(Mandatory, ParameterSetName = 'active-directory')]
        [Parameter(ParameterSetName = 'openldap')]
        [int]
        $SecretId,

        # Tenant ID
        [Parameter(Mandatory, ParameterSetName = 'azure')]
        [string]
        $TenantId,

        # Client ID
        [Parameter(Mandatory, ParameterSetName = 'azure')]
        [string]
        $ClientId,

        # Client Secret
        [Parameter(Mandatory, ParameterSetName = 'azure')]
        [string]
        $ClientSecret,

        # Distinguished Name
        [Parameter(Mandatory, ParameterSetName = 'openldap')]
        [string]
        $DistinguishedName,

        # Authentication type
        [Parameter(Mandatory, ParameterSetName = 'openldap')]
        [Thycotic.PowerShell.Enums.LdapAuthType]
        $AuthType,

        # User Authentication type (only AuthType=Anonymous)
        [Parameter(Mandatory, ParameterSetName = 'openldap')]
        [Thycotic.PowerShell.Enums.UserAuthType]
        $UserAuthType
    )
    begin {
        $tssNewParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssNewParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'directory-services', 'domains' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'

            $newBody = @{data = @{} }
            switch ($tssNewParams.Keys) {
                'TssSession' { <# do nothing, added for performance #> }
                'Active' { $newBody.data.Add('active',[boolean]$Active) }
                'DomainName' { $newBody.data.Add('domainName',$DomainName) }
                'FriendlyName' { $newBody.data.Add('friendlyName',$FriendlyName) }
                'SiteId' { $newBody.data.Add('siteId',$SiteId) }
                'SecretId' { $newBody.data.Add('synchronizationSecretId',$SecretId) }
                'UseSecureLdap' { $newBody.data.Add('useSecureLDAP',[boolean]$UseSecureLdap) }
                'MfaProvider' { $newBody.data.Add('multifactorAuthenticationProvider',$MfaProvider) }
                'TenantId' { $newBody.data.Add('tenantId',$TenantId) }
                'ClientId' { $newBody.data.Add('clientId',$ClientId) }
                'ClientSecret' { $newBody.data.Add('clientSecret',$ClientSecret) }
                'UserAuthType' {
                    if ($UserAuthType -eq 'NoAuthentication') {
                        $newBody.data.Add('userAuthType',$null)
                    } else {
                        $newBody.data.Add('userAuthType',$UserAuthType)
                    }
                }
                'AuthType' { $newBody.data.Add('authType',$AuthType) }
                'DistinguishedName' { $newBody.data.Add('distinguishedName',$DistinguishedName) }
            }

            if ($TenantId) {
                $newBody.data.Add('domainType','AzureActiveDirectory')
            } elseif ($DistinguishedName) {
                $newBody.data.Add('domainType','OpenLdap')
            } else {
                $newBody.data.Add('domainType','ActiveDirectory')
            }
            $invokeParams.Body = ($newBody | ConvertTo-Json -Depth 50)

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri) with:`n $newBody"
            if (-not $PSCmdlet.ShouldProcess("Directory Service: $Name", "$($invokeParams.Method) $($invokeParams.Uri) with $($invokeParams.Body)")) { return }
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue creating Directory Service [$Name]"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                [Thycotic.PowerShell.DirectoryServices.Domain]$restResponse
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}