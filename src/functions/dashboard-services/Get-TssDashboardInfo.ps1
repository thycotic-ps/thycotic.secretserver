function Get-TssDashboardInfo {
    <#
    .SYNOPSIS
    Get the dashboard load information for the current user

    .DESCRIPTION
    Returns what the web UI loads when the dashboard opens: every dashboard tab of the current user, the tab that opens by default, the widgets on that tab, and dashboard configuration settings such as whether passwords can be unmasked.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER NoHtmlEncode
    Return the tab names in Tabs as stored. By default the server HTML-encodes them. The server applies this to Tabs only: LastSelectedTab.TabName is always HTML-encoded.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDashboardInfo -TssSession $session

    Get the dashboard tabs, default tab and its widgets for the current user

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    (Get-TssDashboardInfo -TssSession $session -NoHtmlEncode).Tabs

    List the dashboard tabs with their names as stored, without HTML encoding

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/dashboard-services/Get-TssDashboardInfo

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dashboard-services/Get-TssDashboardInfo.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DashboardServices.DashboardInfo')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $NoHtmlEncode
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'dashboard-services', 'info' -join '/'
            $queryParams = @()
            switch ($tssParams.Keys) {
                'NoHtmlEncode' {
                    $queryParams += "encodeValues=$(-not [boolean]$NoHtmlEncode)"
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
                Write-Warning 'Issue with Get-TssDashboardInfo request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.DashboardServices.DashboardInfo](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DashboardServices.DashboardInfo]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
