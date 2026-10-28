function Get-TssSchedule {
    <#
    .SYNOPSIS
    Get a recurring schedule

    .DESCRIPTION
    Returns a recurring schedule by ID: type, duration, start date, time zone, constraints and the entity it belongs to.
    Recurring schedules drive inbox rule digests.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Recurring schedule ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSchedule -TssSession $session -Id 3

    Returns recurring schedule 3

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/schedules/Get-TssSchedule

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/schedules/Get-TssSchedule.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Schedules.Schedule')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ScheduleId', 'RecurringScheduleId')]
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
                $uri = $TssSession.ApiUrl, 'schedules', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssSchedule request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Schedules.Schedule](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Schedules.Schedule]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
