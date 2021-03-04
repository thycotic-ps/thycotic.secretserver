function Find-User {
    <#
    .SYNOPSIS
    Find for a Secret Server user

    .DESCRIPTION
    Find for a Secret Server User

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Find-TssUser -TssSession $session -DomainId 2

    Return a list of all users assigned to Domain ID 2

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Find-TssUser -TssSession $session -Field Username,Email -FindText demo

    Return a list of all users with "demo" in the username or email

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Find-TssUser

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssUserLookup')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [TssSession]
        $TssSession,

        # Filter users by Active Directory Domain
        [Alias("Domain")]
        [int]
        $DomainId,

        # Include inactive users in results
        [switch]
        $IncludeInactive,

        # User field(s) to Find
        [Alias('FindFields')]
        [string[]]
        $Field,

        # Find text
        [string]
        $FindText,

        # Sort by specific property, default DisplayName
        [string]
        $SortBy = 'DisplayName'
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'users', 'lookup' -join '/'
            $uri = $uri, "sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)" -join '?'

            $filters = @()
            switch ($tssParams.Keys) {
                'DomainId' { $filters += "filter.domainId=$DomainId" }
                'IncludeInactive' { $filters += "filter.includeInactive=$([boolean]$IncludeInactive)" }
                'FindText' { $filters += "filter.FindText=$FindText" }
                'Field' {
                    foreach ($f in $Field) {
                        $filters += "filter.FindFields=$f"
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

            Write-Verbose "$($invokeParams.Method) $uri with: $body"
            try {
                $restResponse = Invoke-TssRestApi @invokeParams
            } catch {
                Write-Warning "Issue on Find request"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse.records.Count -le 0 -and $restResponse.records.Length -eq 0) {
                Write-Warning "No Users found"
            }
            if ($restResponse.records) {
                . $TssUserLookupObject $restResponse.records
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}