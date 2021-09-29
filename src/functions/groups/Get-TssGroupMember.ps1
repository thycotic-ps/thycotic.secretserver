function Get-TssGroupMember {
    <#
    .SYNOPSIS
    Get a Group's membership

    .DESCRIPTION
    Get a Group's membership

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssGroupMember -TssSession $session -Id 2

    Get users that are members of Group 2

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Get-TssGroupMember

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/TssGet-GroupMember.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Groups.UserSummary')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Group ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('GroupId')]
        [int[]]
        $Id,

        # Include inactive Users in Group
        [switch]
        $IncludeInactive,

        # Members that are in a specific domain
        [int]
        $UserDomainId,

        # Sort by specific property, default DisplayName
        [string]
        $SortBy = 'DisplayName'
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }

    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($group in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'groups', $group, 'users' -join '/'
                $uri = $uri, "sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)" -join '?'
                $invokeParams.Method = 'GET'

                $filters = @()
                if ($tssParams.ContainsKey('IncludeInactive')) {
                    $filters += "filter.includeInactiveUsersForGroup=$([boolean]$IncludeInactive)"
                }
                if ($tssParams.ContainsKey('UserDomainId')) {
                    $filters += "filter.userDomainId=$UserDomainId"
                }
                if ($filters) {
                    $uriFilters = $filters -join '&'
                    Write-Verbose "Filters: $uriFilters"
                    $uri = $uri, $uriFilters -join '&'
                }

                $invokeParams.Uri = $uri
                Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue getting Group [$group]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse.records) {
                    [Thycotic.PowerShell.Groups.UserSummary[]]$restResponse.records
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}