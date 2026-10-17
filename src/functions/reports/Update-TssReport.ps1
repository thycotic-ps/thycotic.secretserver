function Update-TssReport {
    <#
    .SYNOPSIS
    Update a report

    .DESCRIPTION
    Update a report by replacing its definition: name, description, category, SQL, chart and paging.
    Every property is sent, so a property not provided is reset.
    Pipe the report from Get-TssReport to keep its current values and change only the parameters provided.
    Reports that require dual control approval to edit cannot be updated with this command.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Report ID

    .PARAMETER Name
    Name of the report

    .PARAMETER Description
    Description of the report, required by Secret Server

    .PARAMETER CategoryId
    Report category ID the report belongs to

    .PARAMETER ReportSql
    SQL query that defines the report

    .PARAMETER ChartType
    Chart type of the report (see Search-TssReportChartType); empty for no chart

    .PARAMETER Is3DReport
    Show the report chart in 3D

    .PARAMETER PageSize
    Number of records per page, default 15

    .PARAMETER UseDatabasePaging
    Page the report in SQL Server instead of the application server

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssReport -TssSession $session -Id 112 | Update-TssReport -TssSession $session -Description 'Secrets changed in the last 30 days'

    Changes the description of report 112, keeping every other property

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssReport -TssSession $session -Id 112 -Name 'Folder count' -Description 'Number of folders' -CategoryId 3 -ReportSql 'SELECT COUNT(*) AS [Folders] FROM tbFolder' -PageSize 50

    Replaces the definition of report 112

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Update-TssReport

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Update-TssReport.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Reports.Report')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ReportId')]
        [int]
        $Id,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ReportName')]
        [string]
        $Name,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]
        $Description,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $CategoryId,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]
        $ReportSql,

        [Parameter(ValueFromPipelineByPropertyName)]
        [string]
        $ChartType,

        [Parameter(ValueFromPipelineByPropertyName)]
        [switch]
        $Is3DReport,

        [Parameter(ValueFromPipelineByPropertyName)]
        [int]
        $PageSize = 15,

        [Parameter(ValueFromPipelineByPropertyName)]
        [switch]
        $UseDatabasePaging
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
            $uri = $TssSession.ApiUrl, 'reports', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $body = [ordered]@{
                id                = $Id
                name              = $Name
                description       = $Description
                categoryId        = $CategoryId
                reportSql         = $ReportSql
                is3DReport        = [boolean]$Is3DReport
                pageSize          = $PageSize
                useDatabasePaging = [boolean]$UseDatabasePaging
            }
            if ($ChartType) {
                $body.Add('chartType', $ChartType)
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Report Id: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue updating report [$Id]"
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Reports.Report](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Reports.Report]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
