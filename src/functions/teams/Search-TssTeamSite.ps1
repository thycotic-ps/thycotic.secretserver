function Search-TssTeamSite {
    <#
    .SYNOPSIS
    Get the sites assigned to a team

    .DESCRIPTION
    Get the Distributed Engine sites assigned to a team. The server returns inactive sites too, whether or not -IncludeInactive is given.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Team ID

    .PARAMETER IncludeInactive
    Send includeInactive=true to the server. The server does not filter on it, so active and inactive sites are returned either way

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssTeamSite -TssSession $session -Id 4

    Returns every site assigned to team 4, active or inactive

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/Search-TssTeamSite

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/Search-TssTeamSite.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Teams.Site[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('TeamId')]
        [int[]]
        $Id,

        [switch]
        $IncludeInactive
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
                $uri = $TssSession.ApiUrl, 'teams', $currentId, 'sites' -join '/'
                $queryParams = @()
                $queryParams += "includeInactive=$([boolean]$IncludeInactive)"
                $uri = $uri, ($queryParams -join '&') -join '?'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Search-TssTeamSite request'
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
