function Get-ThyLogDate {
    $Format = 'MM-dd-yyyy HH:mm:ss.ffffff'
    Get-Date -Format ('{0}' -f $Format)
}

function Start-Log {
    <#
    .SYNOPSIS
    Creates a new log file with header information
    #>
    [CmdletBinding()]
    param (
        # Format of log to generate, default to LOG; allowed: log, csv, json, xml, cmtrace
        [ValidateSet('log', 'csv', 'json', 'xml', 'cmtrace')]
        [string]
        $LogFormat = 'log',

        # Exact log path and filename to use
        [string]
        $LogFilePath,

        # Reference for use with your scripts
        [string]
        $ScriptVersion
    )
    process {
        if ( Test-Path -Path $LogFilePath ) {
            try {
                Remove-Item -Path $LogFilePath -Force -ErrorAction Stop >$null
            } catch {
                throw "Unable to remove file [$LogFilePath]"
            }
        }

        try {
            New-Item -Path $LogFilePath -ItemType File -Force -ErrorAction Stop >$null
        } catch {
            throw "Unable to create file [$LogFilePath]"
        }
        $resolvedFilePath = (Resolve-Path $LogFilePath).Path

        $Msg = [PSCustomObject]@{
            TimeStamp   = Get-ThyLogDate
            MessageType = 'INFO'
            Message     = "Started processing at [$(Get-ThyLogDate)]."
        }

        switch ($LogFormat) {
            'Log' {
                Add-Content -Path $resolvedFilePath -Value "$(Get-ThyLogDate);INFO;************************************************************************************************************************"
                Add-Content -Path $resolvedFilePath -Value "$(Get-ThyLogDate);INFO;..######..########..######..########..########.########.....######..########.########..##.....##.########.########."
                Add-Content -Path $resolvedFilePath -Value "$(Get-ThyLogDate);INFO;.##....##.##.......##....##.##.....##.##..........##.......##....##.##.......##.....##.##.....##.##.......##.....##"
                Add-Content -Path $resolvedFilePath -Value "$(Get-ThyLogDate);INFO;.##.......##.......##.......##.....##.##..........##.......##.......##.......##.....##.##.....##.##.......##.....##"
                Add-Content -Path $resolvedFilePath -Value "$(Get-ThyLogDate);INFO;..######..######...##.......########..######......##........######..######...########..##.....##.######...########."
                Add-Content -Path $resolvedFilePath -Value "$(Get-ThyLogDate);INFO;.......##.##.......##.......##...##...##..........##.............##.##.......##...##....##...##..##.......##...##.."
                Add-Content -Path $resolvedFilePath -Value "$(Get-ThyLogDate);INFO;.##....##.##.......##....##.##....##..##..........##.......##....##.##.......##....##....##.##...##.......##....##."
                Add-Content -Path $resolvedFilePath -Value "$(Get-ThyLogDate);INFO;..######..########..######..##.....##.########....##........######..########.##.....##....###....########.##.....##"
                Add-Content -Path $resolvedFilePath -Value "$(Get-ThyLogDate);INFO;************************************************************************************************************************"
                Add-Content -Path $resolvedFilePath -Value "$(Get-ThyLogDate);INFO;************************************************************************************************************************"
                Add-Content -Path $resolvedFilePath -Value "$(Get-ThyLogDate);INFO;Started processing at [$(Get-ThyLogDate)]."
                Add-Content -Path $resolvedFilePath -Value "$(Get-ThyLogDate);INFO;************************************************************************************************************************"
                Add-Content -Path $resolvedFilePath -Value "$(Get-ThyLogDate);INFO;************************************************************************************************************************"
                Add-Content -Path $resolvedFilePath -Value "$(Get-ThyLogDate);INFO;"
                Add-Content -Path $resolvedFilePath -Value "$(Get-ThyLogDate);INFO;Module Version:     [$((Get-Module Thycotic.SecretServer).Version.ToString())]"
                Add-Content -Path $resolvedFilePath -Value "$(Get-ThyLogDate);INFO;PowerShell Version: [$($PSVersionTable.PSVersion.ToString())]"
                Add-Content -Path $resolvedFilePath -Value "$(Get-ThyLogDate);INFO;OS Version:         [$($PSVersionTable.OS.ToString())]"
                Add-Content -Path $resolvedFilePath -Value "$(Get-ThyLogDate);INFO;Script version:     [$ScriptVersion]."
                Add-Content -Path $resolvedFilePath -Value "$(Get-ThyLogDate);INFO;"
                Add-Content -Path $resolvedFilePath -Value "$(Get-ThyLogDate);INFO;************************************************************************************************************************"
                Add-Content -Path $resolvedFilePath -Value "$(Get-ThyLogDate);INFO;************************************************************************************************************************"
                Add-Content -Path $resolvedFilePath -Value "$(Get-ThyLogDate);INFO;"

                Add-Content -Path $resolvedFilePath -Value "$(Get-ThyLogDate);INFO;Started processing at [$(Get-ThyLogDate)]."
            }
            'xml' {
                $Msg | Export-Clixml $resolvedFilePath
            }
            'json' {
                $Msg | ConvertTo-Json | Out-File $resolvedFilePath
            }
            'csv' {
                if ($PSEdition -eq 'Core') {
                    $Msg | Export-Csv $resolvedFilePath -UseCulture
                } else {
                    $Msg | Export-Csv $resolvedFilePath -UseCulture -NoTypeInformation
                }
            }
            'cmtrace' {
                $toLog = "{0} `$$<{1}><{2}><thread={3}>" -f ($Msg.MessageType + ':' + $Msg.Message), $LogName, $Msg.TimeStamp, $pid
                $toLog | Out-File -Append -Encoding UTF8 -FilePath $resolvedFilePath
            }
        }

        #Write to screen for debug mode
        Write-Debug '************************************************************************************************************************'
        Write-Debug "Started processing at [$(Get-ThyLogDate)]."
        Write-Debug '************************************************************************************************************************'
        Write-Debug ''
        Write-Debug "Running script version [$ScriptVersion]."
        Write-Debug ''
        Write-Debug '************************************************************************************************************************'
        Write-Debug ''
    }
}
function Stop-Log {
    <#
    .SYNOPSIS
    Write closing data to log file & exits the calling script
    #>
    [CmdletBinding()]
    param (
        # Format of log to generate, default to LOG; allowed: log, csv, json, xml, cmtrace
        [ValidateSet('log', 'csv', 'json', 'xml', 'cmtrace')]
        [string]
        $LogFormat = 'log',

        # Exact log path and filename to use
        [string]
        $LogFilePath
    )
    process {
        $resolvedFilePath = (Resolve-Path $LogFilePath).Path

        $Msg = [PSCustomObject]@{
            TimeStamp   = Get-ThyLogDate
            MessageType = 'INFO'
            Message     = "Finished processing at [$(Get-ThyLogDate)]."
        }

        switch ($LogFormat) {
            'log' {
                Add-Content -Path $resolvedFilePath -Value "$(Get-ThyLogDate);INFO;"
                Add-Content -Path $resolvedFilePath -Value "$(Get-ThyLogDate);INFO;************************************************************************************************************************"
                Add-Content -Path $resolvedFilePath -Value "$(Get-ThyLogDate);INFO;Finished processing at [$(Get-ThyLogDate)]."
                Add-Content -Path $resolvedFilePath -Value "$(Get-ThyLogDate);INFO;************************************************************************************************************************"
                Add-Content -Path $resolvedFilePath -Value "$(Get-ThyLogDate);INFO;Finished processing at [$(Get-ThyLogDate)]."
            }
            'xml' {
                [array]$Log = Import-Clixml $resolvedFilePath
                $Log += $Msg | Select-Object TimeStamp, MessageType, Message
                $Log | Export-Clixml $resolvedFilePath
            }
            'json' {
                [array]$Log = Get-Content $resolvedFilePath | ConvertFrom-Json
                $Log += $Msg | Select-Object TimeStamp, MessageType, Message
                $Log | ConvertTo-Json | Out-File $resolvedFilePath
            }
            'csv' {
                [array]$Log = Import-Csv $resolvedFilePath
                $Log += $Msg | Select-Object TimeStamp, MessageType, Message
                if ($PSEdition -eq 'Core') {
                    $Log | Export-Csv $resolvedFilePath -UseCulture
                } else {
                    $Log | Export-Csv $resolvedFilePath -UseCulture -NoTypeInformation
                }
            }
            'cmtrace' {
                $toLog = "{0} `$$<{1}><{2}><thread={3}>" -f ($Msg.MessageType + ':' + $Msg.Message), $LogName, $Msg.TimeStamp, $pid
                $toLog | Out-File -Append -Encoding UTF8 -FilePath $resolvedFilePath
            }
        }

        Write-Debug ''
        Write-Debug '************************************************************************************************************************'
        Write-Debug "Finished processing at [$(Get-ThyLogDate)]."
        Write-Debug '************************************************************************************************************************'
    }
}
function Write-Log {
    <#
    .SYNOPSIS
    Writes a message to specified log file
    #>
    [CmdletBinding()]
    param (
        # Format of log to generate, default to LOG; allowed: log, csv, json, xml, cmtrace
        [ValidateSet('log', 'csv', 'json', 'xml', 'cmtrace')]
        [string]
        $LogFormat = 'log',

        # Exact log path and filename to use
        [string]
        $LogFilePath,

        # Message type, default INFO; allowed: INFO, WARNING, ERROR, FATAL
        [ValidateSet('INFO', 'WARNING', 'ERROR', 'FATAL')]
        [String]
        $MessageType = 'INFO',

        # Message content to write to file
        [Parameter(ValueFromPipeline = $true)]
        [string]
        $Message,

        # Character divider will be added to file as INFO message, using plus sign (+)
        [switch]
        $Divider
    )
    process {
        $resolvedFilePath = (Resolve-Path $LogFilePath).Path

        $Msg = [PSCustomObject]@{
            TimeStamp   = Get-ThyLogDate
            MessageType = $MessageType.ToUpper()
            Message     = $Message
        }

        if ($PSBoundParameters.ContainsKey('Divider')) {
            $dividerValue = ''
            1..120 | ForEach-Object { $dividerValue += '+' }
            $MessageToFile = '{0};{1};{2}' -f $Msg.TimeStamp, 'INFO', $dividerValue
        } else {
            $MessageToFile = '{0};{1};{2}' -f $Msg.TimeStamp, $Msg.MessageType, $Msg.Message
        }

        switch ($LogFormat) {
            'log' {
                Add-Content -Path $resolvedFilePath -Value $MessageToFile
            }
            'xml' {
                [array]$Log = Import-Clixml $resolvedFilePath
                $Log += $Msg | Select-Object TimeStamp, MessageType, Message
                $Log | Export-Clixml $resolvedFilePath
            }
            'json' {
                [array]$Log = Get-Content $resolvedFilePath | ConvertFrom-Json
                $Log += $Msg | Select-Object TimeStamp, MessageType, Message
                $Log | ConvertTo-Json | Out-File $resolvedFilePath
            }
            'csv' {
                [array]$Log = Import-Csv $resolvedFilePath
                $Log += $Msg | Select-Object TimeStamp, MessageType, Message
                if ($PSEdition -eq 'Core') {
                    $Log | Export-Csv $resolvedFilePath -UseCulture
                } else {
                    $Log | Export-Csv $resolvedFilePath -UseCulture -NoTypeInformation
                }
            }
            'cmtrace' {
                $toLog = "{0} `$$<{1}><{2}><thread={3}>" -f ($Msg.MessageType + ':' + $Msg.Message), $LogPath, $Msg.TimeStamp, $pid
                $toLog | Out-File -Append -Encoding UTF8 -FilePath $resolvedFilePath
            }
        }

        #Write to screen for debug mode
        Write-Debug $MessageToFile
    }
}

# Export the public functions
Export-ModuleMember -Function 'Start-Log', 'Stop-Log', 'Write-Log'