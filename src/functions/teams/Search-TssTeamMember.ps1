function Search-TssTeamMember {
    <#
    .SYNOPSIS
    Search the members of a team

    .DESCRIPTION
    Search the members of a team by display name. Usernames are not matched. Each result resolves the member's user details (user ID, username, domain) where the member is a user.
    Use Get-TssTeamMember to get the team's group memberships.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Team ID

    .PARAMETER SearchText
    Return only members whose display name matches this text. Usernames are not matched

    .PARAMETER DomainId
    Return only members from this directory domain ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssTeamMember -TssSession $session -Id 4

    Returns every member of team 4

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssTeamMember -TssSession $session -Id 4 -SearchText 'admin'

    Returns the members of team 4 whose display name matches admin

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/Search-TssTeamMember

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/Search-TssTeamMember.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Teams.MemberSummary[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('TeamId')]
        [int[]]
        $Id,

        [string]
        $SearchText,

        [int]
        $DomainId
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
                $uri = $TssSession.ApiUrl, 'teams', $currentId, 'members', 'search' -join '/'
                $queryParams = @()
                $queryParams += "take=$($TssSession.Take)"
                $queryParams += "filter.searchText=$([uri]::EscapeDataString([string]$SearchText))"
                if ($tssParams.ContainsKey('DomainId')) {
                    $queryParams += "filter.domainId=$DomainId"
                }
                $uri = $uri, ($queryParams -join '&') -join '?'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Search-TssTeamMember request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.records) {
                    [Thycotic.PowerShell.Teams.MemberSummary[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Teams.MemberSummary]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
