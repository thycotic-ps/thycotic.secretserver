function Search-TssJumpboxRoute {
    <#
    .SYNOPSIS
    Search jumpbox routes

    .DESCRIPTION
    Returns the jumpbox routes that match the filters.
    Only active routes are returned unless you pass -IncludeInactive.
    Requires the View Jumpbox Route or Administer Jumpbox Route role permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER IncludeActive
    Include active routes. Active routes are included by default; use -IncludeActive:$false to leave them out

    .PARAMETER IncludeInactive
    Include inactive routes. Defaults to on when you pass -IncludeActive:$false, off otherwise

    .PARAMETER SearchTerm
    Return only routes whose name matches this text

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssJumpboxRoute -TssSession $session -IncludeInactive

    Returns every jumpbox route, active or not

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssJumpboxRoute -TssSession $session -SearchTerm 'DMZ'

    Returns the active jumpbox routes with "DMZ" in the name

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/jumpbox-route/Search-TssJumpboxRoute

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/jumpbox-route/Search-TssJumpboxRoute.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.JumpboxRoute.JumpboxRouteItem[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $IncludeActive,

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
            $uri = $TssSession.ApiUrl, 'jumpbox-route', 'search' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            $includeActive = -not $tssParams.ContainsKey('IncludeActive') -or $IncludeActive.IsPresent
            $includeInactive = if ($tssParams.ContainsKey('IncludeInactive')) { $IncludeInactive.IsPresent } else { -not $includeActive }
            $queryParams += "filter.includeActive=$includeActive"
            $queryParams += "filter.includeInactive=$includeInactive"
            switch ($tssParams.Keys) {
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
                Write-Warning 'Issue with Search-TssJumpboxRoute request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.JumpboxRoute.JumpboxRouteItem[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.JumpboxRoute.JumpboxRouteItem]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
