function Remove-TssTeamMember {
    <#
    .SYNOPSIS
    Remove groups from a team

    .DESCRIPTION
    Remove groups from a team's membership. Team members are groups; a user is removed through the user's personal group.
    Members are identified by group ID. Removing a group that is not on the team changes nothing.
    Returns the team's remaining members.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Team ID

    .PARAMETER GroupId
    Group IDs to remove from the team

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssTeamMember -TssSession $session -Id 4 -GroupId 12,15

    Removes groups 12 and 15 from team 4 and returns the remaining members

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/Remove-TssTeamMember

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/Remove-TssTeamMember.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Teams.Member[]')]
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
        $GroupId
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
            $uri = $TssSession.ApiUrl, 'teams', $Id, 'members' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'DELETE'
            $body = @{ data = @{ groupIds = @($GroupId) } }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Team: $Id | Group ID: $($GroupId -join ', ')", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Remove-TssTeamMember request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.records) {
                    [Thycotic.PowerShell.Teams.Member[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Teams.Member]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
