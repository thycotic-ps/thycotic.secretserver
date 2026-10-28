function Set-TssDiscoveryDependencyRule {
    <#
    .SYNOPSIS
    Update a Discovery dependency rule

    .DESCRIPTION
    Updates the given fields of a Discovery dependency rule and returns the updated rule. Fields not given are unchanged.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Dependency rule id

    .PARAMETER DiscoverySourceId
    Discovery source the rule applies to

    .PARAMETER IsActive
    Activate the rule; use -IsActive:$false to deactivate it

    .PARAMETER OrganizationUnitId
    Organizational unit the rule applies to

    .PARAMETER PrivilegedAccountSecretId
    Secret of the privileged account used to manage the dependencies

    .PARAMETER RestartServices
    Restart the services after a password change; use -RestartServices:$false to stop

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
    Set-TssDiscoveryDependencyRule -TssSession $session -Id 4 -RuleName 'Web farm app pools' -RestartServices

    Rename dependency rule 4 and restart services after a password change

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDiscoveryDependencyRule -TssSession $session -Id 4 -IsActive:$false

    Deactivate dependency rule 4

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Set-TssDiscoveryDependencyRule

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Set-TssDiscoveryDependencyRule.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Discovery.DependencyRule')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('RuleId')]
        [int]
        $Id,

        [int]
        $DiscoverySourceId,

        [switch]
        $IsActive,

        [int]
        $OrganizationUnitId,

        [int]
        $PrivilegedAccountSecretId,

        [switch]
        $RestartServices,

        [string]
        $RuleName,

        [int]
        $ScanTemplateId,

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
            $uri = $TssSession.ApiUrl, 'discovery', 'rules', 'dependencies', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'DiscoverySourceId' {
                    $body.data.Add('discoverySourceId', @{ dirty = $true; value = $DiscoverySourceId })
                }
                'IsActive' {
                    $body.data.Add('isActive', @{ dirty = $true; value = [boolean]$IsActive })
                }
                'OrganizationUnitId' {
                    $body.data.Add('organizationUnitId', @{ dirty = $true; value = $OrganizationUnitId })
                }
                'PrivilegedAccountSecretId' {
                    $body.data.Add('privilegedAccountSecretId', @{ dirty = $true; value = $PrivilegedAccountSecretId })
                }
                'RestartServices' {
                    $body.data.Add('restartServices', @{ dirty = $true; value = [boolean]$RestartServices })
                }
                'RuleName' {
                    $body.data.Add('ruleName', @{ dirty = $true; value = $RuleName })
                }
                'ScanTemplateId' {
                    $body.data.Add('scanTemplateId', @{ dirty = $true; value = $ScanTemplateId })
                }
                'SecretDependencyTemplateId' {
                    $body.data.Add('secretDependencyTemplateId', @{ dirty = $true; value = $SecretDependencyTemplateId })
                }
                'SiteId' {
                    $body.data.Add('siteId', @{ dirty = $true; value = $SiteId })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Discovery dependency rule: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssDiscoveryDependencyRule request'
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
