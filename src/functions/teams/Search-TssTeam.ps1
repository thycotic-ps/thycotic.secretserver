function Search-TssTeam {
    <#
    .SYNOPSIS
    Search teams

    .DESCRIPTION
    Search teams by name. Only active teams are returned unless -IncludeInactive is given.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER SearchTerm
    Return only teams whose name matches this text

    .PARAMETER IncludeInactive
    Include inactive teams

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssTeam -TssSession $session

    Returns every active team

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssTeam -TssSession $session -SearchTerm 'Operations' -IncludeInactive

    Returns active and inactive teams whose name matches Operations

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/Search-TssTeam

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/Search-TssTeam.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Teams.Team[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [string]
        $SearchTerm,

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
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'teams' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            $queryParams += "filter.includeInactive=$([boolean]$IncludeInactive)"
            if ($tssParams.ContainsKey('SearchTerm')) {
                $queryParams += "filter.searchTerm=$([uri]::EscapeDataString($SearchTerm))"
            }
            $uri = $uri, ($queryParams -join '&') -join '?'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssTeam request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Teams.Team[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Teams.Team]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
