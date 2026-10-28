function Search-TssPlatformUsersGroups {
    <#
    .SYNOPSIS
    Search Delinea Platform users and groups

    .DESCRIPTION
    Search the Delinea Platform for users or groups, optionally showing or excluding those already linked to Secret Server users and groups.
    The Platform returns at most 100 identities per page; this cmdlet follows the next-page link until every page is read.
    Returns nothing when Platform integration is not enabled.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER EntityType
    Search Users (default) or Groups

    .PARAMETER ExcludeLinkedLocalEntities
    Leave out identities already linked to a Secret Server user or group

    .PARAMETER NextLink
    Next-page link to start from instead of the first page

    .PARAMETER PlatformDirectoryUuid
    Platform directory Id (GUID) to search, from Search-TssPlatformDirectory

    .PARAMETER SearchText
    Start of the name. The Platform matches names that start with this text; * is not a wildcard, so 'adm' finds admin but 'adm*' does not

    .PARAMETER ShowLinkedLocalEntities
    Include the Secret Server user or group Id linked to each identity

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssPlatformUsersGroups -TssSession $session -SearchText 'Admin' -EntityType Groups -ShowLinkedLocalEntities

    Find Platform groups starting with Admin and show the Secret Server group each is linked to

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Search-TssPlatformUsersGroups

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Search-TssPlatformUsersGroups.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Platform.UserGroupSummary[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [ValidateSet('Users', 'Groups')]
        [string]
        $EntityType,

        [switch]
        $ExcludeLinkedLocalEntities,

        [string]
        $NextLink,

        [string]
        $PlatformDirectoryUuid,

        [string]
        $SearchText,

        [switch]
        $ShowLinkedLocalEntities
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $filterParams = @()
            $filterParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'EntityType' {
                    $filterParams += "filter.entityType=$([uri]::EscapeDataString($EntityType))"
                }
                'ExcludeLinkedLocalEntities' {
                    $filterParams += "filter.excludeLinkedLocalEntities=$([boolean]$ExcludeLinkedLocalEntities)"
                }
                'PlatformDirectoryUuid' {
                    $filterParams += "filter.platformDirectoryUuid=$([uri]::EscapeDataString($PlatformDirectoryUuid))"
                }
                'SearchText' {
                    $filterParams += "filter.searchText=$([uri]::EscapeDataString($SearchText))"
                }
                'ShowLinkedLocalEntities' {
                    $filterParams += "filter.showLinkedLocalEntities=$([boolean]$ShowLinkedLocalEntities)"
                }
            }
            $pageLink = $NextLink
            $readLinks = [System.Collections.Generic.HashSet[string]]::new()
            do {
                $restResponse = $null
                $queryParams = $filterParams
                if ($pageLink) {
                    [void]$readLinks.Add($pageLink)
                    $queryParams += "filter.nextLink=$([uri]::EscapeDataString($pageLink))"
                }
                $uri = $TssSession.ApiUrl, 'platform', 'users-groups-search' -join '/'
                $uri = $uri, ($queryParams -join '&') -join '?'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Search-TssPlatformUsersGroups request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.records) {
                    [Thycotic.PowerShell.Platform.UserGroupSummary[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Platform.UserGroupSummary]))
                }
                $pageLink = $restResponse.nextLink
            } while ($pageLink -and -not $readLinks.Contains($pageLink))
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
