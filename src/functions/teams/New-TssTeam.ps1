function New-TssTeam {
    <#
    .SYNOPSIS
    Create a new team

    .DESCRIPTION
    Create a new team and return its ID. The team name must be unique.
    Teams cannot be deleted through the REST API; use Update-TssTeam -Active:$false to deactivate a team.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER TeamName
    Team name, unique and up to 250 characters

    .PARAMETER TeamDescription
    Team description, up to 2000 characters

    .PARAMETER DomainId
    Directory domain ID to associate with the team

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $teamId = New-TssTeam -TssSession $session -TeamName 'Operations' -TeamDescription 'Operations team'
    Get-TssTeam -TssSession $session -Id $teamId

    Creates the Operations team and gets it by the returned ID

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/New-TssTeam

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/New-TssTeam.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType([int])]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [ValidateLength(1, 250)]
        [string]
        $TeamName,

        [ValidateLength(0, 2000)]
        [string]
        $TeamDescription,

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
            $uri = $TssSession.ApiUrl, 'teams' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ teamName = $TeamName }
            switch ($tssParams.Keys) {
                'TeamDescription' {
                    $body.Add('teamDescription', $TeamDescription)
                }
                'DomainId' {
                    $body.Add('domainId', $DomainId)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Team: $TeamName", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssTeam request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($null -ne $restResponse) {
                    [int]$restResponse
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
