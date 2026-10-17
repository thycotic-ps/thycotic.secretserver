function Update-TssTeam {
    <#
    .SYNOPSIS
    Update a team

    .DESCRIPTION
    Update the name, description, active state, or directory domain of a team. Only the parameters given are changed.
    The team name must stay unique. Use -Active:$false to deactivate a team.
    Returns the updated team.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Team ID

    .PARAMETER Active
    Set the team active, or inactive with -Active:$false

    .PARAMETER DomainId
    Directory domain ID to associate with the team

    .PARAMETER TeamDescription
    New team description

    .PARAMETER TeamName
    New team name

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssTeam -TssSession $session -Id 4 -TeamDescription 'Operations and on-call'

    Changes the description of team 4

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssTeam -TssSession $session -Id 4 -Active:$false

    Deactivates team 4

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/Update-TssTeam

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/Update-TssTeam.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Teams.Team')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('TeamId')]
        [int]
        $Id,

        [switch]
        $Active,

        [int]
        $DomainId,

        [string]
        $TeamDescription,

        [string]
        $TeamName
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'teams', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $body = @{ }
            switch ($tssParams.Keys) {
                'Active' {
                    $body.Add('active', @{ dirty = $true; value = [boolean]$Active })
                }
                'DomainId' {
                    $body.Add('domainId', @{ dirty = $true; value = $DomainId })
                }
                'TeamDescription' {
                    $body.Add('teamDescription', @{ dirty = $true; value = $TeamDescription })
                }
                'TeamName' {
                    $body.Add('teamName', @{ dirty = $true; value = $TeamName })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Team: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssTeam request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Teams.Team](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Teams.Team]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
