function Search-TssRole {
    <#
    .SYNOPSIS
    Search Roles

    .DESCRIPTION
    Search Roles

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssRole -TssSession $session -UserId 43

    Returns roles assigned to User ID 43

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/roles/Search-TssRole

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/roles/Search-TssRole.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'user')]
    [OutputType('Thycotic.PowerShell.Roles.Role')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]

        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Only return roles assigned to this User ID
        [Parameter(ParameterSetName = 'user')]
        [int]
        $UserId,

        # Only return roles assigned to this Group ID
        [Parameter(ParameterSetName = 'group')]
        [int]
        $GroupId,

        # Include inactive roles in the results
        [Parameter(ParameterSetName = 'user')]
        [Parameter(ParameterSetName = 'group')]
        [switch]
        $IncludeInactive,

        # Sort by specific property, default Name
        [Parameter(ParameterSetName = 'user')]
        [Parameter(ParameterSetName = 'group')]
        [string]
        $SortBy = 'Name'
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
            $uri = $TssSession.ApiUrl, 'roles' -join '/'
            $uri = $uri, "sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)" -join '?'

            $filters = @()
            if ($tssParams.ContainsKey('UserId')) {
                $filters += "filter.userId=$UserId"
            }
            if ($tssParams.ContainsKey('GroupId')) {
                $filters += "filter.groupId=$GroupId"
            }
            if ($tssParams.ContainsKey('IncludeInactive')) {
                $filters += "filter.includeInactive=$([boolean]$IncludeInactive)"
            }
            if ($filters) {
                $uriFilter = $filters -join '&'
                Write-Verbose "Filters: $uriFilter"
                $uri = $uri, $uriFilter -join '&'
            }

            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'

            Write-Verbose "Performing the operation $($invokeParams.Method) $uri with: $body"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue on search request'
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse.records.Count -le 0 -and $restResponse.records.Length -eq 0) {
                Write-Warning 'No Roles found'
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Roles.Role[]]$restResponse.records
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}