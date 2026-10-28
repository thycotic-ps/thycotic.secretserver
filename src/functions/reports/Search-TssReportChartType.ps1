function Search-TssReportChartType {
    <#
    .SYNOPSIS
    List the chart types available for reports

    .DESCRIPTION
    List the chart types (Id and Name) a report can use for its ChartType.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssReportChartType -TssSession $session

    Returns every report chart type with its Id and Name

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Search-TssReportChartType

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Search-TssReportChartType.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Reports.ChartType[]')]
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
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'reports', 'charttypes' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssReportChartType request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Reports.ChartType[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Reports.ChartType]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
