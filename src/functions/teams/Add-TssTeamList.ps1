function Add-TssTeamList {
    <#
    .SYNOPSIS
    Add categorized lists to a team

    .DESCRIPTION
    Add categorized lists to a team, optionally changing whether the team is restricted to its lists.
    The server replaces the team's whole list set with the IDs it is sent. By default this command first reads the team's current lists (Search-TssTeamList) and sends them together with -ListId, so existing lists are kept. Use -Replace to set the team's lists to exactly -ListId.
    When the team is restricted to its lists, at least one list must remain assigned.
    Returns the lists assigned to the team after the change.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Team ID

    .PARAMETER ListId
    Categorized list IDs to add to the team

    .PARAMETER Replace
    Set the team's lists to exactly -ListId, removing any list not given

    .PARAMETER ShouldRestrictLists
    Restrict the team to its assigned lists. Leave it out to keep the current setting

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Add-TssTeamList -TssSession $session -Id 4 -ListId 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e'

    Adds the list to team 4, keeping the lists already assigned

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Add-TssTeamList -TssSession $session -Id 4 -ListId 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e','6c1b0f7e-4f1c-4e0b-9a43-2a8f3c9d1e55' -Replace -ShouldRestrictLists

    Sets team 4's lists to exactly the two lists and restricts the team to them

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/Add-TssTeamList

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/Add-TssTeamList.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Lists.SummaryList[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('TeamId')]
        [int]
        $Id,

        [Parameter(Mandatory)]
        [Alias('CategorizedListId')]
        [string[]]
        $ListId,

        [switch]
        $Replace,

        [switch]
        $ShouldRestrictLists
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
            $listIds = @($ListId)
            if (-not $Replace) {
                $currentLists = Search-TssTeamList -TssSession $TssSession -Id $Id -ErrorAction Stop
                $listIds = @(@($currentLists.CategorizedListId) + $listIds | Where-Object { $null -ne $_ } | ForEach-Object { "$_".ToLowerInvariant() } | Sort-Object -Unique)
            }
            $uri = $TssSession.ApiUrl, 'teams', $Id, 'lists' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{
                listIds = @{ dirty = $true; value = $listIds }
            }
            if ($tssParams.ContainsKey('ShouldRestrictLists')) {
                $body.shouldRestrictLists = @{ dirty = $true; value = [boolean]$ShouldRestrictLists }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Team: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Add-TssTeamList request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.lists) {
                    [Thycotic.PowerShell.Lists.SummaryList[]](. $FilterTssResponse $restResponse.lists ([Thycotic.PowerShell.Lists.SummaryList]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
