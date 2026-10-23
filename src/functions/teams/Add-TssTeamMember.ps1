function Add-TssTeamMember {
    <#
    .SYNOPSIS
    Add groups to a team

    .DESCRIPTION
    Add groups to a team's membership. Team members are groups; a user is added through the user's personal group.
    By default the groups are added to the existing members and groups already on the team are skipped.
    Use -Replace to set the team's members to exactly -GroupId, removing any group not given. Only a replace writes a team audit entry.
    Returns the team's members after the change.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Team ID

    .PARAMETER GroupId
    Group IDs to add to the team

    .PARAMETER Replace
    Set the team's members to exactly -GroupId, removing any group not given

    .PARAMETER DomainId
    Directory domain ID sent with a replace

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Add-TssTeamMember -TssSession $session -Id 4 -GroupId 12,15

    Adds groups 12 and 15 to team 4, keeping its other members

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Add-TssTeamMember -TssSession $session -Id 4 -GroupId 12 -Replace

    Sets team 4's members to group 12 only

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/Add-TssTeamMember

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/Add-TssTeamMember.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'add', SupportsShouldProcess)]
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
        $GroupId,

        [Parameter(Mandatory, ParameterSetName = 'replace')]
        [switch]
        $Replace,

        [Parameter(ParameterSetName = 'replace')]
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
            $restResponse = $null
            if ($Replace) {
                $uri = $TssSession.ApiUrl, 'teams', $Id, 'members' -join '/'
                $domainField = @{ dirty = $false; value = $null }
                if ($tssParams.ContainsKey('DomainId')) {
                    $domainField = @{ dirty = $true; value = $DomainId }
                }
                $body = @{
                    groupIds = @{ dirty = $true; value = @($GroupId) }
                    domainId = $domainField
                }
            } else {
                $uri = ($TssSession.ApiUrl -replace '/api/v1$','/api/v2'), 'teams', $Id, 'members' -join '/'
                $body = @{ data = @{ groupIds = @($GroupId) } }
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Team: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Add-TssTeamMember request'
                    $err = $_
                    . $ErrorHandling $err
                }
                $members = if ($Replace) { $restResponse } else { $restResponse.records }
                if ($members) {
                    [Thycotic.PowerShell.Teams.Member[]](. $FilterTssResponse $members ([Thycotic.PowerShell.Teams.Member]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
