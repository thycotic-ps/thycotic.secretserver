function Get-TssHeartbeatLog {
    <#
    .SYNOPSIS
    Get the heartbeat log

    .DESCRIPTION
    Gets the heartbeat log shown under Admin, Diagnostics: the heartbeat monitor status messages from the last month.
    Secret Server returns the log as comma-separated text. Each entry becomes one object; text that contains commas or line breaks is kept whole. CreatedOn is the text the server wrote, in the server culture.
    When the server truncates the log it adds a notice, which is written as a warning.
    Requires the Administer Configuration or View Configuration permission. Without the View Remote Password Changing or Administer Remote Password Changing permission the server returns an empty log.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssHeartbeatLog -TssSession $session

    Get the heartbeat log entries from the last month

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssHeartbeatLog -TssSession $session | Where-Object Text -Match 'fail'

    Get the heartbeat log entries that mention a failure

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Get-TssHeartbeatLog

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Get-TssHeartbeatLog.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Diagnostics.HeartbeatLog')]
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
            $uri = $TssSession.ApiUrl, 'diagnostics', 'heartbeat-logs' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssHeartbeatLog request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                $logText = if ($restResponse.StartsWith('"')) { $restResponse | ConvertFrom-Json } else { $restResponse }
                $entries = [System.Collections.Generic.List[string]]::new()
                foreach ($line in ($logText -split '\r?\n')) {
                    if ($line -like 'Warning: Logs truncated*') {
                        Write-Warning $line
                    } elseif ($line -like 'RPCHeartBeatMonitor,*') {
                        $entries.Add($line)
                    } elseif ($entries.Count) {
                        $entries[$entries.Count - 1] = $entries[$entries.Count - 1], $line -join "`n"
                    }
                }
                if ($logText -and -not $entries.Count) {
                    Write-Warning 'The heartbeat log was returned in an unexpected format, no entries were read'
                }
                foreach ($entry in $entries) {
                    $record = $entry.TrimEnd()
                    $machineStart = $record.IndexOf(',') + 1
                    $textStart = $record.IndexOf(',', $machineStart) + 1
                    $createdStart = $record.LastIndexOf(',') + 1
                    if ($textStart -gt 0 -and $createdStart -gt $textStart) {
                        [Thycotic.PowerShell.Diagnostics.HeartbeatLog]@{
                            ThreadName  = $record.Substring(0, $machineStart - 1)
                            MachineName = $record.Substring($machineStart, $textStart - $machineStart - 1)
                            Text        = $record.Substring($textStart, $createdStart - $textStart - 1)
                            CreatedOn   = $record.Substring($createdStart)
                        }
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
