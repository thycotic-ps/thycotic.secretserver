function Set-TssDiscoverySource {
    <#
    .SYNOPSIS
    Update a discovery source

    .DESCRIPTION
    Updates the name, site, credential secret, active state, OU scope or machine retention of a discovery source.
    Only the parameters given are changed.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Discovery source ID

    .PARAMETER Active
    Make the source active, or inactive with -Active:$false

    .PARAMETER DaysToKeepMachines
    Days to keep machines that are no longer found

    .PARAMETER DiscoverSpecificOUs
    Only discover the OUs in the filter of the source (Active Directory sources)

    .PARAMETER MachineNameResolutionType
    How discovered machines are named: UseMachineNameAndFQDM or OnlyUseMachineName

    .PARAMETER Name
    Discovery source name

    .PARAMETER SecretId
    ID of the secret used as the default discovery credential of the source

    .PARAMETER SiteId
    ID of the site that runs the scanners of the source

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDiscoverySource -TssSession $session -Id 3 -Name 'Linux servers'

    Rename discovery source 3

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDiscoverySource -TssSession $session -Id 3 -Active:$false

    Make discovery source 3 inactive

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Set-TssDiscoverySource

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Set-TssDiscoverySource.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Discovery.Source')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $Id,

        [switch]
        $Active,

        [int]
        $DaysToKeepMachines,

        [switch]
        $DiscoverSpecificOUs,

        [ValidateSet('UseMachineNameAndFQDM', 'OnlyUseMachineName')]
        [string]
        $MachineNameResolutionType,

        [string]
        $Name,

        [int]
        $SecretId,

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
            $uri = $TssSession.ApiUrl, 'discovery', 'source', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Active' {
                    $body.data.Add('active', @{ dirty = $true; value = [boolean]$Active })
                }
                'DaysToKeepMachines' {
                    $body.data.Add('daysToKeepMachines', @{ dirty = $true; value = $DaysToKeepMachines })
                }
                'DiscoverSpecificOUs' {
                    $body.data.Add('discoverSpecificOUs', @{ dirty = $true; value = [boolean]$DiscoverSpecificOUs })
                }
                'MachineNameResolutionType' {
                    $body.data.Add('machineNameResolutionType', @{ dirty = $true; value = $MachineNameResolutionType })
                }
                'Name' {
                    $body.data.Add('name', @{ dirty = $true; value = $Name })
                }
                'SecretId' {
                    $body.data.Add('secretId', @{ dirty = $true; value = $SecretId })
                }
                'SiteId' {
                    $body.data.Add('siteId', @{ dirty = $true; value = $SiteId })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Discovery source: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssDiscoverySource request'
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
