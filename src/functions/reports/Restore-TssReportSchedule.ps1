function Restore-TssReportSchedule {
    <#
    .SYNOPSIS
    Restore a deleted report schedule

    .DESCRIPTION
    Restore (undelete) a deleted report schedule so it runs again.
    Returns True when the schedule was restored.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Report schedule ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Restore-TssReportSchedule -TssSession $session -Id 7

    Restores deleted report schedule 7

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssReportSchedule -TssSession $session -IncludeDeleted | Where-Object Deleted | Restore-TssReportSchedule -TssSession $session

    Restores every deleted report schedule

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Restore-TssReportSchedule

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Restore-TssReportSchedule.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('System.Boolean')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ScheduleReportId', 'ReportScheduleId')]
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
                $uri = $TssSession.ApiUrl, 'reports', 'schedules', $currentId, 'undelete' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'PUT'
                if ($PSCmdlet.ShouldProcess("Report schedule Id: $currentId", "$($invokeParams.Method) $uri")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue restoring report schedule [$currentId]"
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($null -ne $restResponse) {
                        [boolean]::Parse([string]$restResponse)
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
