function Search-TssRoleGroup {
    <#
    .SYNOPSIS
    Search the groups assigned to a role

    .DESCRIPTION
    Returns the groups assigned to a role.
    Disabled groups and the personal groups of inactive users are not returned.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Role ID

    .PARAMETER IncludeInactiveUsersForGroup
    Passed to the API, but Secret Server does not apply it: the result is the same with or without it

    .PARAMETER UserDomainId
    Only return groups in this domain ID

    .PARAMETER UserStatus
    User status filter. Secret Server validates the value but does not apply it: the result is the same for every valid value

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssRoleGroup -TssSession $session -Id 7

    Returns the groups assigned to role ID 7

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/roles/Search-TssRoleGroup

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/roles/Search-TssRoleGroup.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Roles.Group[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('RoleId')]
        [int[]]
        $Id,

        [switch]
        $IncludeInactiveUsersForGroup,

        [int]
        $UserDomainId,

        [string]
        $UserStatus
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
                $uri = $TssSession.ApiUrl, 'roles', $currentId, 'groups' -join '/'
                $queryParams = @()
                $queryParams += "take=$($TssSession.Take)"
                switch ($tssParams.Keys) {
                    'IncludeInactiveUsersForGroup' {
                        $queryParams += "filter.includeInactiveUsersForGroup=$([boolean]$IncludeInactiveUsersForGroup)"
                    }
                    'UserDomainId' {
                        $queryParams += "filter.userDomainId=$($UserDomainId)"
                    }
                    'UserStatus' {
                        $queryParams += "filter.userStatus=$([uri]::EscapeDataString($UserStatus))"
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
                    Write-Warning 'Issue with Search-TssRoleGroup request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.records) {
                    [Thycotic.PowerShell.Roles.Group[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Roles.Group]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
