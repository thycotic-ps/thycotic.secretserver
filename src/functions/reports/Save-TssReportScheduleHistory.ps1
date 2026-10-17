function Save-TssReportScheduleHistory {
    <#
    .SYNOPSIS
    Save the stored report file of a report schedule run

    .DESCRIPTION
    Download the report file stored for a report schedule run and save it to a folder.
    The file name is the one Secret Server stores for the run; when none is returned the file is named report-schedule-history-<HistoryId>.
    Returns the saved file.
    Use Search-TssReportScheduleHistory to find the history IDs of a schedule.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Report schedule history ID (ScheduleReportHistoryId of a run)

    .PARAMETER Output
    Folder to save the file in

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Save-TssReportScheduleHistory -TssSession $session -Id 112 -Output .\reports

    Saves the report file of report schedule run 112 to the reports folder

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssReportScheduleHistory -TssSession $session -Id 7 | Save-TssReportScheduleHistory -TssSession $session -Output .\reports

    Saves the report file of every stored run of report schedule 7

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Save-TssReportScheduleHistory

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Save-TssReportScheduleHistory.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('System.IO.FileInfo')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ScheduleReportHistoryId', 'HistoryId')]
        [int[]]
        $Id,

        [Parameter(Mandatory)]
        [ValidateScript( { Test-Path $_ -PathType Container })]
        [string]
        $Output
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $outputFolder = (Resolve-Path -Path $Output).ProviderPath
            foreach ($currentId in $Id) {
                $apiResponse = $null
                $uri = $TssSession.ApiUrl, 'reports', 'schedules', $currentId, 'history', 'download' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $null = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue downloading report schedule history [$currentId]"
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($apiResponse.IsSuccessful -and $apiResponse.RawBytes) {
                    $responseHeaders = @($apiResponse.Headers) + @($apiResponse.ContentHeaders)
                    $fileName = ($responseHeaders | Where-Object { $_.Name -eq 'File-Name' } | Select-Object -First 1).Value
                    if ($fileName) {
                        $fileName = [IO.Path]::GetFileName([string]$fileName)
                    }
                    if (-not $fileName) {
                        $fileName = "report-schedule-history-$currentId"
                    }
                    $filePath = [IO.Path]::Combine($outputFolder, $fileName)
                    [IO.File]::WriteAllBytes($filePath, $apiResponse.RawBytes)
                    Get-Item -LiteralPath $filePath
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
