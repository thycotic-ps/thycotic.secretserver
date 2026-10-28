function Search-TssGroupUser {
    <#
    .SYNOPSIS
    Search users for a group, members and non-members

    .DESCRIPTION
    Searches users against a group. Each result says whether the user is a member of the group (Assigned).
    Without Assigned both members and non-members are returned. Get-TssGroupMember returns members only.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Group ID

    .PARAMETER SearchTerm
    Only users whose display name contains this text

    .PARAMETER Assigned
    Only members of the group. Use -Assigned:$false for users that are not members; omit it for both

    .PARAMETER DomainId
    Only users in this directory domain. Use -1 for local users

    .PARAMETER UserStatus
    Only users with this status. All users when omitted

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssGroupUser -TssSession $session -Id 42 -SearchTerm smith

    Finds users with smith in their display name and shows whether each is a member of group 42

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssGroupUser -TssSession $session -Id 42 -Assigned:$false -UserStatus Enabled

    Lists enabled users that are not members of group 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Search-TssGroupUser

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Search-TssGroupUser.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Groups.MemberSummary[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('GroupId')]
        [int[]]
        $Id,

        [string]
        $SearchTerm,

        [switch]
        $Assigned,

        [int]
        $DomainId,

        [ValidateSet('EnabledAndDisabled', 'Enabled', 'Disabled')]
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
            Compare-TssVersion $TssSession '11.7.000000' $PSCmdlet.MyInvocation
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'groups', $currentId, 'users', 'search' -join '/'
                $largestTakeTheServerCanDouble = [int]::MaxValue -shr 1
                $queryParams = @()
                $queryParams += "take=$([Math]::Min($TssSession.Take, $largestTakeTheServerCanDouble))"
                $queryParams += "filter.searchTerm=$([uri]::EscapeDataString([string]$SearchTerm))"
                switch ($tssParams.Keys) {
                    'Assigned' {
                        $queryParams += "filter.assigned=$([boolean]$Assigned)"
                    }
                    'DomainId' {
                        $queryParams += "filter.domainId=$($DomainId)"
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
                    Write-Warning 'Issue with Search-TssGroupUser request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.users.records) {
                    [Thycotic.PowerShell.Groups.MemberSummary[]](. $FilterTssResponse $restResponse.users.records ([Thycotic.PowerShell.Groups.MemberSummary]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
