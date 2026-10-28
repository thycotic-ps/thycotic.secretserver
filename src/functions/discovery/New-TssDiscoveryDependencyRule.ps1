function New-TssDiscoveryDependencyRule {
    <#
    .SYNOPSIS
    Create a Discovery dependency rule

    .DESCRIPTION
    Creates a Discovery dependency rule that imports dependencies found by a scan template on a discovery source, and returns the created rule.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER DiscoverySourceId
    Discovery source the rule applies to

    .PARAMETER OrganizationUnitId
    Organizational unit the rule applies to

    .PARAMETER PrivilegedAccountSecretId
    Secret of the privileged account used to manage the dependencies. Required when Get-TssDiscoveryDependencyRuleInfo returns IsPrivilegedSecretRequired for the scan template

    .PARAMETER RestartServices
    Restart the services after a password change

    .PARAMETER RuleName
    Rule name

    .PARAMETER ScanTemplateId
    Dependency scan template id (scan type 4)

    .PARAMETER SecretDependencyTemplateId
    Dependency template that sets the dependency type

    .PARAMETER SiteId
    Site that runs the dependency changes

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssDiscoveryDependencyRule -TssSession $session -RuleName 'Web farm services' -DiscoverySourceId 1 -ScanTemplateId 15 -SecretDependencyTemplateId 6 -PrivilegedAccountSecretId 42 -RestartServices

    Create a Windows service dependency rule for discovery source 1 that uses secret 42 and restarts services after a password change

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/New-TssDiscoveryDependencyRule

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/New-TssDiscoveryDependencyRule.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Discovery.DependencyRule')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [int]
        $DiscoverySourceId,

        [int]
        $OrganizationUnitId,

        [int]
        $PrivilegedAccountSecretId,

        [switch]
        $RestartServices,

        [Parameter(Mandatory)]
        [string]
        $RuleName,

        [Parameter(Mandatory)]
        [int]
        $ScanTemplateId,

        [Parameter(Mandatory)]
        [int]
        $SecretDependencyTemplateId,

        [int]
        $SiteId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'discovery', 'rules', 'dependencies' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'DiscoverySourceId' {
                    $body.data.Add('discoverySourceId', $DiscoverySourceId)
                }
                'OrganizationUnitId' {
                    $body.data.Add('organizationUnitId', $OrganizationUnitId)
                }
                'PrivilegedAccountSecretId' {
                    $body.data.Add('privilegedAccountSecretId', $PrivilegedAccountSecretId)
                }
                'RestartServices' {
                    $body.data.Add('restartServices', [boolean]$RestartServices)
                }
                'RuleName' {
                    $body.data.Add('ruleName', $RuleName)
                }
                'ScanTemplateId' {
                    $body.data.Add('scanTemplateId', $ScanTemplateId)
                }
                'SecretDependencyTemplateId' {
                    $body.data.Add('secretDependencyTemplateId', $SecretDependencyTemplateId)
                }
                'SiteId' {
                    $body.data.Add('siteId', $SiteId)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Discovery dependency rule", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssDiscoveryDependencyRule request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Discovery.DependencyRule](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Discovery.DependencyRule]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
