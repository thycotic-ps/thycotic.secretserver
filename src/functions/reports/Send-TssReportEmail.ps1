function Send-TssReportEmail {
    <#
    .SYNOPSIS
    Email a report

    .DESCRIPTION
    Run a report and email the result to an email address.
    Secret Server sends the email through its configured SMTP server.
    Returns True when Secret Server accepted the email.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Report ID

    .PARAMETER EmailAddress
    Email address the report is sent to

    .PARAMETER Format
    Format of the report in the email: Html or Csv, default Html

    .PARAMETER Parameters
    Report parameters provided as hash format of @{<Parameter Name> = <Param Value>}

    .PARAMETER DateOptionId
    ID of the date format used for dates in the report

    .PARAMETER TimeOptionId
    ID of the time format used for times in the report

    .PARAMETER TimeZoneOptionId
    Time zone ID used for dates and times in the report

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Send-TssReportEmail -TssSession $session -Id 60 -EmailAddress 'audit@example.com' -Format Csv

    Emails report 60 to audit@example.com in CSV format

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Send-TssReportEmail -TssSession $session -Id 3 -EmailAddress 'audit@example.com' -Parameters @{startdate = '2026-01-01'}

    Emails report 3 in HTML format, with its start date parameter set

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Send-TssReportEmail

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Send-TssReportEmail.ps1

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
        [Alias('ReportId')]
        [int]
        $Id,

        [Parameter(Mandatory)]
        [string]
        $EmailAddress,

        [ValidateSet('Html', 'Csv')]
        [string]
        $Format = 'Html',

        [hashtable]
        $Parameters,

        [int]
        $DateOptionId,

        [int]
        $TimeOptionId,

        [string]
        $TimeZoneOptionId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'reports', $Id, 'email' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $reportParams = @()
            foreach ($param in $Parameters.Keys) {
                $reportParams += [ordered]@{
                    name  = $param
                    value = $Parameters.$param
                }
            }
            $body = @{
                data = @{
                    emailAddress = $EmailAddress
                    format       = $Format
                    parameters   = $reportParams
                }
            }
            switch ($tssParams.Keys) {
                'DateOptionId' {
                    $body.data.Add('dateOptionId', $DateOptionId)
                }
                'TimeOptionId' {
                    $body.data.Add('timeOptionId', $TimeOptionId)
                }
                'TimeZoneOptionId' {
                    $body.data.Add('timeZoneOptionId', $TimeZoneOptionId)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Report Id: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue emailing report [$Id]"
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($null -ne $restResponse) {
                    [boolean]$restResponse.success
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
