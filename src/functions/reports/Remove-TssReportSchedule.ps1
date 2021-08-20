function Remove-TssReportSchedule {
    <#
    .SYNOPSIS
    Remove a report schedule

    .DESCRIPTION
    Remove a report schedule

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssReportSchedule -TssSession $session -ScheduleId 46

    Remove report schedule 46

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Remove-TssReportSchedule

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Remove-TssReportSchedule.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Common.Delete')]
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
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($schedule in $ScheduleId) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'reports', 'schedules', $schedule -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'DELETE'

                if (-not $PSCmdlet.ShouldProcess("Report Schedule:$schedule","$($invokeParams.Method) $uri")) { return }
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with $body"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue removing report schedule [$schedule]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    [Thycotic.PowerShell.Common.Delete]@{
                        Id         = $schedule
                        ObjectType = 'Report Schedule'
                    }
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}