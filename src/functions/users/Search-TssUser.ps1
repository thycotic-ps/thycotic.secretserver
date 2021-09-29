function Search-TssUser {
    <#
    .SYNOPSIS
    Search for a Secret Server user

    .DESCRIPTION
    Search for a Secret Server User

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssUser -TssSession $session -DomainId 2

    Return a list of all users assigned to Domain ID 2

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssUser -TssSession $session -Field Username,Email -SearchText demo

    Return a list of all users with "demo" in the username or email

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Search-TssUser

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Search-TssUser.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Users.Summary')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Filter users by Active Directory Domain
        [Alias('Domain')]
        [int]
        $DomainId,

        # Include inactive users in results
        [switch]
        $IncludeInactive,

        # User field(s) to search
        [Alias('SearchFields')]
        [string[]]
        $Field,

        # Search text
        [string]
        $SearchText,

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
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'users' -join '/'
            $uri = $uri, "sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)" -join '?'

            $filters = @()
            switch ($tssParams.Keys) {
                'DomainId' { $filters += "filter.domainId=$DomainId" }
                'IncludeInactive' { $filters += "filter.includeInactive=$([boolean]$IncludeInactive)" }
                'SearchText' { $filters += "filter.searchText=$SearchText" }
                'Field' {
                    foreach ($f in $Field) {
                        $filters += "filter.searchFields=$f"
                    }
                }
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
                Write-Warning 'No Users found'
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Users.Summary[]]$restResponse.records
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}