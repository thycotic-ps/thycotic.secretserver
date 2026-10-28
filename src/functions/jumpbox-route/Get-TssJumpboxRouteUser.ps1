function Get-TssJumpboxRouteUser {
    <#
    .SYNOPSIS
    Get the jumpbox routes available to the current user

    .DESCRIPTION
    Returns the jumpbox routes the signed-in user can pick when launching a proxied SSH session.
    Unlike Search-TssJumpboxRoute it needs no role permission.
    The result includes a row with an empty JumpboxRouteId that stands for connecting without a jumpbox route.

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
    Get-TssJumpboxRouteUser -TssSession $session

    Returns the active jumpbox routes the signed-in user can use

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssJumpboxRouteUser -TssSession $session -SearchTerm 'DMZ' -IncludeInactive

    Returns the active and inactive routes with "DMZ" in the name that the signed-in user can use

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/jumpbox-route/Get-TssJumpboxRouteUser

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/jumpbox-route/Get-TssJumpboxRouteUser.ps1

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
            $uri = $TssSession.ApiUrl, 'jumpbox-route', 'user' -join '/'
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
                Write-Warning 'Issue with Get-TssJumpboxRouteUser request'
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
