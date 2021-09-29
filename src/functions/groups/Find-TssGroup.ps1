function Find-TssGroup {
    <#
    .SYNOPSIS
    Find for a Secret Server Group

    .DESCRIPTION
    Find for a Secret Server Group (domain or local)

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Find-TssGroup

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Find-TssGroup.ps1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Find-TssGroup -TssSession $session -DomainId 1

    Return list of Groups found in Secret Server for Domain Directory 1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha/SecretServer -Credential $ssCred
    Find-TssGroup -TssSession $session -SearchText 'IT'

    Return list of Groups found in Secret Server matching the characters IT

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Groups.Lookup')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Director Services Domain Id
        [int]
        $DomainId,

        # Limit to groups the current user can view details
        [switch]
        $ViewableGroups,

        # Search text
        [string]
        $SearchText,

        # Include inactive Groups
        [switch]
        $IncludeInactive,

        # Sort by specific property, default Name
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
            $uri = $TssSession.ApiUrl, 'groups', 'lookup' -join '/'
            $uri = $uri, "sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)" -join '?'
            $invokeParams.Method = 'GET'

            $filters = @()
            switch ($tssParams.Keys) {
                'DomainId' { $filters += "filter.domainId=$DomainId" }
                'IncludeInactive' { $filters += "filter.includeInactive=$([boolean]$IncludeInactive)" }
                'ViewableGroups' { $filters += "filter.limitToViewableGroups=$([boolean]$ViewableGroups)" }
                'SearchText' { $filters += "filter.searchText=$SearchText" }
            }
            if ($filters) {
                $uriFilter = $filters -join '&'
                Write-Verbose "Filters: $uriFilter"
                $uri = $uri, $uriFilter -join '&'
            }
            $invokeParams.Uri = $uri

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue on find request'
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse.records.Count -le 0 -and $restResponse.records.Length -eq 0) {
                Write-Warning 'No Group found'
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Groups.Lookup[]]$restResponse.records
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}