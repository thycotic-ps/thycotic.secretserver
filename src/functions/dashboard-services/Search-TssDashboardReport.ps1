function Search-TssDashboardReport {
    <#
    .SYNOPSIS
    List the reports available to the dashboard

    .DESCRIPTION
    Returns the active reports the current user can add to the dashboard, with the report id, name, category and whether the report has a chart. The list is not paged.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDashboardReport -TssSession $session

    List the active reports available to the dashboard

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDashboardReport -TssSession $session | Where-Object HasChart

    List the dashboard reports that have a chart

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/dashboard-services/Search-TssDashboardReport

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dashboard-services/Search-TssDashboardReport.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DashboardServices.DashboardReport[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'dashboard-services', 'reports' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssDashboardReport request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.DashboardServices.DashboardReport[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DashboardServices.DashboardReport]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
