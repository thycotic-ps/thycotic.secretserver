function Search-TssLauncher {
    <#
    .SYNOPSIS
    Search launchers

    .DESCRIPTION
    Search launchers (Remote Desktop, PuTTY, Website Login and custom launchers) and return a summary of each.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Application
    Launcher application to filter by, for example mstsc, putty or web

    .PARAMETER IncludeInactive
    Include inactive launchers

    .PARAMETER SearchText
    Text to match against the launcher name

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssLauncher -TssSession $session -IncludeInactive

    Get every launcher, active and inactive

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/launchers/Search-TssLauncher

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launchers/Search-TssLauncher.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Launchers.Summary[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [string]
        $Application,

        [switch]
        $IncludeInactive,

        [string]
        $SearchText
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'launchers' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'Application' {
                    $queryParams += "filter.application=$([uri]::EscapeDataString($Application))"
                }
                'IncludeInactive' {
                    $queryParams += "filter.includeInactive=$([boolean]$IncludeInactive)"
                }
                'SearchText' {
                    $queryParams += "filter.searchText=$([uri]::EscapeDataString($SearchText))"
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
                Write-Warning 'Issue with Search-TssLauncher request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Launchers.Summary[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Launchers.Summary]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
