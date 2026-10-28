function Search-TssReportAudit {
    <#
    .SYNOPSIS
    Search report audit entries

    .DESCRIPTION
    Search the audit trail of reports: views, edits, exports and other report actions.
    Without Id it returns audit entries for all reports; with Id it returns the entries of those reports.
    Returns up to the session's Take value of entries per call.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Report ID; returns only the audit entries of these reports

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssReportAudit -TssSession $session

    Returns audit entries for all reports

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssReportAudit -TssSession $session -Id 60 | Select-Object DateRecorded, Action, DisplayName

    Returns when, what and who for each entry in the audit trail of report 60

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Search-TssReportAudit

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Search-TssReportAudit.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'all')]
    [OutputType('Thycotic.PowerShell.Reports.Audit[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'report')]
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
            $auditUris = @()
            if ($PSCmdlet.ParameterSetName -eq 'report') {
                foreach ($currentId in $Id) {
                    $uri = $TssSession.ApiUrl, 'reports', $currentId, 'audits' -join '/'
                    $auditUris += $uri
                }
            } else {
                $uri = $TssSession.ApiUrl, 'reports', 'audits' -join '/'
                $auditUris += $uri
            }
            foreach ($auditUri in $auditUris) {
                $restResponse = $null
                $invokeParams.Uri = $auditUri, "take=$($TssSession.Take)" -join '?'
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Search-TssReportAudit request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.records) {
                    [Thycotic.PowerShell.Reports.Audit[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Reports.Audit]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
