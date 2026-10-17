function New-TssDiscoverySource {
    <#
    .SYNOPSIS
    Create a discovery source

    .DESCRIPTION
    Creates a discovery source with no scanners. Add scanners with Add-TssDiscoverySourceScanner.
    With -ActiveDirectory, creates an Active Directory discovery source for a domain instead, using the domain settings given.
    An Active Directory source is created active unless -Active:$false is given.
    Secret Server always creates the domain as an Active Directory domain with the user principal name import format.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER DiscoverySourceType
    Type of discovery source to create

    .PARAMETER Name
    Discovery source name

    .PARAMETER SiteId
    ID of the site that runs the scanners of the source (Get-TssSite)

    .PARAMETER SecretId
    ID of the secret used as the default discovery credential of the source; required with -ActiveDirectory

    .PARAMETER ActiveDirectory
    Create an Active Directory discovery source

    .PARAMETER Active
    Create the Active Directory source active (default true)

    .PARAMETER DiscoverSpecificOUs
    Only discover the OUs in the filter of the source

    .PARAMETER MachineNameResolutionType
    How discovered machines are named: UseMachineNameAndFQDM or OnlyUseMachineName

    .PARAMETER FullyQualifiedDomainName
    Fully qualified name of the domain, for example corp.example.com

    .PARAMETER FriendlyName
    Display name of the domain

    .PARAMETER UseSecureLdap
    Connect to the domain with LDAPS

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssDiscoverySource -TssSession $session -Name 'Linux servers' -DiscoverySourceType Unix -SiteId 1

    Create a Unix discovery source run by site 1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssDiscoverySource -TssSession $session -ActiveDirectory -Name 'Corp domain' -FullyQualifiedDomainName corp.example.com -FriendlyName CORP -SecretId 42 -SiteId 1

    Create an Active Directory discovery source for corp.example.com that scans with secret 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/New-TssDiscoverySource

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/New-TssDiscoverySource.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default', SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Discovery.Source')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ParameterSetName = 'Default')]
        [ValidateSet('Unix', 'ODBC', 'FileLoad', 'ManualInput', 'ESX', 'ActiveDirectory', 'PowerShell', 'AmazonWebService', 'GoogleCloudProvider', 'EntraId')]
        [string]
        $DiscoverySourceType,

        [Parameter(Mandatory, ParameterSetName = 'Default')]
        [Parameter(Mandatory, ParameterSetName = 'ActiveDirectory')]
        [string]
        $Name,

        [Parameter(Mandatory, ParameterSetName = 'Default')]
        [Parameter(Mandatory, ParameterSetName = 'ActiveDirectory')]
        [int]
        $SiteId,

        [Parameter(ParameterSetName = 'Default')]
        [Parameter(Mandatory, ParameterSetName = 'ActiveDirectory')]
        [int]
        $SecretId,

        [Parameter(Mandatory, ParameterSetName = 'ActiveDirectory')]
        [switch]
        $ActiveDirectory,

        [Parameter(ParameterSetName = 'ActiveDirectory')]
        [switch]
        $Active,

        [Parameter(ParameterSetName = 'ActiveDirectory')]
        [switch]
        $DiscoverSpecificOUs,

        [Parameter(ParameterSetName = 'ActiveDirectory')]
        [ValidateSet('UseMachineNameAndFQDM', 'OnlyUseMachineName')]
        [string]
        $MachineNameResolutionType,

        [Parameter(ParameterSetName = 'ActiveDirectory')]
        [string]
        $FullyQualifiedDomainName,

        [Parameter(ParameterSetName = 'ActiveDirectory')]
        [string]
        $FriendlyName,

        [Parameter(ParameterSetName = 'ActiveDirectory')]
        [switch]
        $UseSecureLdap
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
                'ActiveDirectory' {
                    $uri = $TssSession.ApiUrl, 'discovery', 'source', 'active-directory' -join '/'
                    $body = @{
                        data = @{
                            name               = $Name
                            siteId             = $SiteId
                            secretId           = $SecretId
                            discoveryScannerId = 'ActiveDirectory'
                            active             = (-not $tssParams.ContainsKey('Active')) -or [boolean]$Active
                        }
                    }
                    $settings = @{ }
                    switch ($tssParams.Keys) {
                        'DiscoverSpecificOUs' {
                            $body.data.Add('discoverSpecificOUs', [boolean]$DiscoverSpecificOUs)
                        }
                        'MachineNameResolutionType' {
                            $body.data.Add('machineNameResolutionType', $MachineNameResolutionType)
                        }
                        'FullyQualifiedDomainName' {
                            $settings.Add('fullyQualifiedDomainName', $FullyQualifiedDomainName)
                        }
                        'FriendlyName' {
                            $settings.Add('friendlyName', $FriendlyName)
                        }
                        'UseSecureLdap' {
                            $settings.Add('useSecureLDAP', [boolean]$UseSecureLdap)
                        }
                    }
                    if ($settings.Count -gt 0) {
                        $body.data.Add('discoverySourceSettings', $settings)
                    }
                }
                default {
                    $uri = ($TssSession.ApiUrl -replace 'v1','v2'), 'discovery', 'source' -join '/'
                    $body = @{
                        data = @{
                            discoverySourceType = $DiscoverySourceType
                            name                = $Name
                            siteId              = $SiteId
                        }
                    }
                    if ($tssParams.ContainsKey('SecretId')) {
                        $body.data.Add('secretId', $SecretId)
                    }
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            if ($PSCmdlet.ShouldProcess("Discovery source: $Name", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssDiscoverySource request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Discovery.Source](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Discovery.Source]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
