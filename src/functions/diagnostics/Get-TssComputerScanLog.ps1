function Get-TssComputerScanLog {
    <#
    .SYNOPSIS
    Get the computer scan log

    .DESCRIPTION
    Gets the computer scan log shown under Admin, Diagnostics: the status messages the ComputerScanConsumer background thread wrote in the last month.
    Secret Server returns the log as comma-separated text. Each entry becomes one object; text that contains commas or line breaks is kept whole. CreatedOn is the text the server wrote, in the server culture.
    When the server truncates the log it adds a notice, which is written as a warning. An empty log returns nothing.
    Requires the Administer Configuration or View Configuration permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssComputerScanLog -TssSession $session

    Get the computer scan log entries from the last month

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssComputerScanLog -TssSession $session | Where-Object Text -Match 'error'

    Get the entries that mention an error

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Get-TssComputerScanLog

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Get-TssComputerScanLog.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Diagnostics.LogEntry[]')]
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
            $uri = $TssSession.ApiUrl, 'diagnostics', 'computer-scan-logs' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssComputerScanLog request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                $logText = if ($restResponse.StartsWith('"')) { $restResponse | ConvertFrom-Json } else { $restResponse }
                $entries = [System.Collections.Generic.List[string]]::new()
                foreach ($line in ($logText -split '\r?\n')) {
                    if ($line -like 'Warning: Logs truncated*' -or $line -like 'Error gathering *') {
                        Write-Warning $line
                    } elseif ($line -like 'ComputerScanConsumer,*') {
                        $entries.Add($line)
                    } elseif ($entries.Count) {
                        $entries[$entries.Count - 1] = $entries[$entries.Count - 1], $line -join "`n"
                    }
                }
                if ($logText -and -not $entries.Count) {
                    Write-Warning 'The computer scan log was returned in an unexpected format, no entries were read'
                }
                foreach ($entry in $entries) {
                    $record = $entry.TrimEnd()
                    $machineStart = $record.IndexOf(',') + 1
                    $textStart = $record.IndexOf(',', $machineStart) + 1
                    $createdStart = $record.LastIndexOf(',') + 1
                    if ($textStart -gt 0 -and $createdStart -gt $textStart) {
                        [Thycotic.PowerShell.Diagnostics.LogEntry]@{
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
