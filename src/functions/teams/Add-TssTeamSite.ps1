function Add-TssTeamSite {
    <#
    .SYNOPSIS
    Add sites to a team

    .DESCRIPTION
    Add Distributed Engine sites to a team, optionally changing whether the team is restricted to its sites.
    The server replaces the team's whole site set with the IDs it is sent. By default this command first reads the team's current sites (Search-TssTeamSite -IncludeInactive) and sends them together with -SiteId, so existing sites are kept. Use -Replace to set the team's sites to exactly -SiteId.
    When the team is restricted to its sites, at least one site must remain assigned. Sites cannot be sent in the same call that turns the restriction off.
    Returns the team's sites after the change.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Team ID

    .PARAMETER SiteId
    Site IDs to add to the team

    .PARAMETER Replace
    Set the team's sites to exactly -SiteId, removing any site not given

    .PARAMETER ShouldRestrictSites
    Restrict the team to its assigned sites. Leave it out to keep the current setting

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Add-TssTeamSite -TssSession $session -Id 4 -SiteId 3

    Adds site 3 to team 4, keeping the sites already assigned

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Add-TssTeamSite -TssSession $session -Id 4 -SiteId 1,3 -Replace -ShouldRestrictSites

    Sets team 4's sites to exactly sites 1 and 3 and restricts the team to them

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/Add-TssTeamSite

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/Add-TssTeamSite.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Teams.Site[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('TeamId')]
        [int]
        $Id,

        [Parameter(Mandatory)]
        [int[]]
        $SiteId,

        [switch]
        $Replace,

        [switch]
        $ShouldRestrictSites
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
            $siteIds = @($SiteId)
            if (-not $Replace) {
                $currentSites = Search-TssTeamSite -TssSession $TssSession -Id $Id -IncludeInactive -ErrorAction Stop
                $siteIds = @(@($currentSites.SiteId) + $siteIds | Where-Object { $null -ne $_ } | Sort-Object -Unique)
            }
            $uri = $TssSession.ApiUrl, 'teams', $Id, 'sites' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $restrictField = @{ dirty = $false; value = $false }
            if ($tssParams.ContainsKey('ShouldRestrictSites')) {
                $restrictField = @{ dirty = $true; value = [boolean]$ShouldRestrictSites }
            }
            $body = @{
                siteIds             = @{ dirty = $true; value = $siteIds }
                shouldRestrictSites = $restrictField
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Team: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Add-TssTeamSite request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Teams.Site[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Teams.Site]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
