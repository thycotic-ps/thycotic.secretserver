function Search-TssScheduleLog {
    <#
    .SYNOPSIS
    Search the recurring schedule log

    .DESCRIPTION
    Returns recurring schedule log entries, optionally filtered by text and by date range.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER EndDate
    Return entries logged on or before this date

    .PARAMETER SearchText
    Text to search the log messages for

    .PARAMETER StartDate
    Return entries logged on or after this date

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssScheduleLog -TssSession $session -StartDate (Get-Date).AddDays(-1)

    Returns the recurring schedule log entries of the last day

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/schedules/Search-TssScheduleLog

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/schedules/Search-TssScheduleLog.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Schedules.ScheduleLog[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [datetime]
        $EndDate,

        [string]
        $SearchText,

        [datetime]
        $StartDate
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'schedules-log' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'EndDate' {
                    $queryParams += "filter.endDate=$([uri]::EscapeDataString($EndDate.ToString('o')))"
                }
                'SearchText' {
                    $queryParams += "filter.searchText=$([uri]::EscapeDataString($SearchText))"
                }
                'StartDate' {
                    $queryParams += "filter.startDate=$([uri]::EscapeDataString($StartDate.ToString('o')))"
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
                Write-Warning 'Issue with Search-TssScheduleLog request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Schedules.ScheduleLog[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Schedules.ScheduleLog]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
