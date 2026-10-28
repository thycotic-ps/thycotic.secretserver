function Search-TssTeamList {
    <#
    .SYNOPSIS
    Get the categorized lists assigned to a team

    .DESCRIPTION
    Get the categorized lists assigned to a team.
    Without -SearchText every list assigned to the team is returned. With -SearchText only the team's lists whose name matches are returned, using the paged list search.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Team ID

    .PARAMETER SearchText
    Return only the team's lists whose name matches this text

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssTeamList -TssSession $session -Id 4

    Returns every categorized list assigned to team 4

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssTeamList -TssSession $session -Id 4 -SearchText 'Servers'

    Returns the lists assigned to team 4 whose name matches Servers

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/Search-TssTeamList

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/Search-TssTeamList.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Lists.SummaryList[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('TeamId')]
        [int[]]
        $Id,

        [string]
        $SearchText
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
                if ($tssParams.ContainsKey('SearchText')) {
                    $uri = $TssSession.ApiUrl, 'teams', 'lists' -join '/'
                    $queryParams = @()
                    $queryParams += "take=$($TssSession.Take)"
                    $queryParams += "filter.teamId=$currentId"
                    $queryParams += "filter.searchText=$([uri]::EscapeDataString($SearchText))"
                    $uri = $uri, ($queryParams -join '&') -join '?'
                } else {
                    $uri = $TssSession.ApiUrl, 'teams', $currentId, 'lists' -join '/'
                }
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Search-TssTeamList request'
                    $err = $_
                    . $ErrorHandling $err
                }
                $lists = if ($tssParams.ContainsKey('SearchText')) { $restResponse.records } else { $restResponse.lists }
                if ($lists) {
                    [Thycotic.PowerShell.Lists.SummaryList[]](. $FilterTssResponse $lists ([Thycotic.PowerShell.Lists.SummaryList]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
