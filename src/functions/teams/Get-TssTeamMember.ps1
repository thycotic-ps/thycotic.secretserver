function Get-TssTeamMember {
    <#
    .SYNOPSIS
    Get the members of a team

    .DESCRIPTION
    Get the group memberships of a team. Team members are groups; a user is a member through the user's personal group, shown with type User.
    Use Search-TssTeamMember to filter members by name and get user details.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Team ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssTeamMember -TssSession $session -Id 4

    Returns the members of team 4

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/Get-TssTeamMember

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/Get-TssTeamMember.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Teams.Member[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('TeamId')]
        [int[]]
        $Id
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
                $uri = $TssSession.ApiUrl, 'teams', $currentId, 'members' -join '/'
                $queryParams = @()
                $queryParams += "take=$($TssSession.Take)"
                $uri = $uri, ($queryParams -join '&') -join '?'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssTeamMember request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Teams.Member[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Teams.Member]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
