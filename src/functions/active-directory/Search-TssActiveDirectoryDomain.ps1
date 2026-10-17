function Search-TssActiveDirectoryDomain {
    <#
    .SYNOPSIS
    Search directory domains through the legacy Active Directory endpoint

    .DESCRIPTION
    Search the directory domains (Active Directory, Azure AD, OpenLDAP) through the legacy active-directory endpoint. Unlike Search-TssDirectoryServiceDomain it returns the distinguished name, site and concurrency ID of each domain.
    Active domains only unless -IncludeInactive is passed.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER SearchText
    Text to match in the domain name or friendly name

    .PARAMETER IncludeInactive
    Include inactive domains

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssActiveDirectoryDomain -TssSession $session -IncludeInactive

    List every directory domain, active or not

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssActiveDirectoryDomain -TssSession $session -SearchText corp | Select-Object DomainId, DomainName, DistinguishedName

    Find domains matching corp and show their distinguished names

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/active-directory/Search-TssActiveDirectoryDomain

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/active-directory/Search-TssActiveDirectoryDomain.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server marks this endpoint obsolete in favor of the directory-services endpoints; it still answers on current versions.
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.ActiveDirectory.DomainSummary[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [string]
        $SearchText,

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
            $uri = $TssSession.ApiUrl, 'active-directory', 'domains' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'SearchText' {
                    $queryParams += "filter.searchText=$([uri]::EscapeDataString($SearchText))"
                }
                'IncludeInactive' {
                    $queryParams += "filter.includeInactive=$([boolean]$IncludeInactive)"
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
                Write-Warning 'Issue with Search-TssActiveDirectoryDomain request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.ActiveDirectory.DomainSummary[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.ActiveDirectory.DomainSummary]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
