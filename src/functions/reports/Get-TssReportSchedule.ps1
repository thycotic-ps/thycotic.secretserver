function Get-TssReportSchedule {
    <#
    .SYNOPSIS
    Get a Report Schedule

    .DESCRIPTION
    Get a Report Schedule

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssReportSchedule -TssSession $session -Id 35

    Get Report Schedule ID 35

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Get-TssReportSchedule

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Get-TssReportSchedule.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Reports.ReportSchedule')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Report Schedule ID
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("ReportScheduleId")]
        [int[]]
        $ScheduleId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000032' $PSCmdlet.MyInvocation
            foreach ($schedule in $ScheduleId) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'reports', 'schedules', $schedule -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue getting schedule [$schedule]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    . $GetReportSchedule $restResponse
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}