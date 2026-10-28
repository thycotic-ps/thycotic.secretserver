function Get-TssReportScheduleStub {
    <#
    .SYNOPSIS
    Get a default report schedule for a report

    .DESCRIPTION
    Get a report schedule stub for a report: the default values Secret Server fills in for a new schedule of that report.
    Nothing is created; use New-TssReportSchedule to create the schedule.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Report ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssReportScheduleStub -TssSession $session -Id 60

    Returns the default schedule values for a new schedule of report 60

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Get-TssReportScheduleStub

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Get-TssReportScheduleStub.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Reports.ReportSchedule')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ReportId')]
        [int[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'reports', 'schedules', 'stub', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue getting schedule stub for report [$currentId]"
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    . $GetReportSchedule $restResponse
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
