function Search-TssUserTeam {
    <#
    .SYNOPSIS
    List the teams of a user

    .DESCRIPTION
    Lists the teams a user belongs to, directly or through a group.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    User ID

    .PARAMETER IncludeGroupMemberships
    Include the groups through which the user belongs to each team

    .PARAMETER IncludeInactive
    Include inactive teams

    .PARAMETER SearchTerm
    Text to match against the team name

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssUserTeam -TssSession $session -Id 42 -IncludeGroupMemberships

    Lists the teams of user 42 with the groups that grant each membership

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Search-TssUserTeam

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Search-TssUserTeam.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Users.Team[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('UserId')]
        [int[]]
        $Id,

        [switch]
        $IncludeGroupMemberships,

        [switch]
        $IncludeInactive,

        [string]
        $SearchTerm
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
                $uri = $TssSession.ApiUrl, 'users', $currentId, 'teams' -join '/'
                $queryParams = @()
                $queryParams += "take=$($TssSession.Take)"
                switch ($tssParams.Keys) {
                    'IncludeGroupMemberships' {
                        $queryParams += "filter.includeGroupMemberships=$([boolean]$IncludeGroupMemberships)"
                    }
                    'IncludeInactive' {
                        $queryParams += "filter.includeInactive=$([boolean]$IncludeInactive)"
                    }
                    'SearchTerm' {
                        $queryParams += "filter.searchTerm=$([uri]::EscapeDataString($SearchTerm))"
                    }
                }
                if ($queryParams) {
                    $uri = $uri, ($queryParams -join '&') -join '?'
                }
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Search-TssUserTeam request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.records) {
                    [Thycotic.PowerShell.Users.Team[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Users.Team]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
