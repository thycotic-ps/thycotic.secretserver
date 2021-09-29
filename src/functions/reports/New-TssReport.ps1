function New-TssReport {
    <#
    .SYNOPSIS
    Short of what command does

    .DESCRIPTION
    Longer of what command does

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssReport -TssSession $session -ReportName 'TssTestReport' -CategoryId 15 -ReportSql "SELECT 1" -Description 'Tss Test Report for POC'

    Creates a new report with minimum requirements Name, CategoryId, ReportSql and Description

    .EXAMPLE
    $session = New-TssSession -SecretServer 'https://alpha/SecretServer' -Credential $ssCred
    $params = @{
        ReportName = 'Tss Test Report from SQL File'
        Category = (Get-TssReportCategory -TssSession $session -All | Where-Object Name -eq 'TssCategory').CategoryId
        Description = 'Test report using SQL file'
        ReportSql = (Get-Content .\tests\exports\testReport.sql | Out-String)
    }
    New-TssReport -TssSession $session @params

    Create a new report where the T-SQL is stored in a SQL script file

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/New-TssReport

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/New-TssReport.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Reports.Report')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Name of the report
        [Parameter(Mandatory,
            ValueFromPipeline,
            Position = 1)]
        [Alias('Name')]
        [string]
        $ReportName,

        # Category for the report
        [Parameter(Mandatory, ValueFromPipeline, Position = 2)]
        [int]
        $CategoryId,

        # Description of the report
        [Parameter(Mandatory, ValueFromPipeline)]
        [string]
        $Description,

        # Chart type for the report
        [string]
        $ChartType,

        # Report chart should be 3D
        [switch]
        $Is3DReport,

        # Number of records the report should return per page
        [int]
        $PageSize,

        # Perform paging in the database (default) or application server
        [ValidateSet('Database', 'Application')]
        [string]
        $Paging = 'Database',

        # T-SQL for the report to run
        [Parameter(Mandatory, ValueFromPipeline)]
        [string]
        $ReportSql
    )
    begin {
        $tssNewReportParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssNewReportParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'reports' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'

            $newReportBody = [ordered]@{}
            switch ($tssNewReportParams.Keys) {
                'CategoryId' { $newReportBody.Add('categoryId', $CategoryId) }
                'ChartType' { $newReportBody.Add('chartType', $ChartType) }
                'Description' { $newReportBody.Add('description', $Description) }
                'Is3DReport' { $newReportBody.Add('is3DReport', $Is3DReport) }
                'ReportName' { $newReportBody.Add('name', $ReportName) }
                'PageSize' { $newReportBody.Add('pageSize', $PageSize) }
                'ReportSql' { $newReportBody.Add('reportSql', $ReportSql) }
                'Paging' {
                    if ($_ -eq 'Application') {
                        $newReportBody.Add('useDatabasePaging', $false)
                    } else {
                        $newReportBody.Add('useDatabasePaging', $true)
                    }
                }
            }
            $invokeParams.Body = ($newReportBody | ConvertTo-Json)

            Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n $newReportBody"
            if (-not $PSCmdlet.ShouldProcess($ReportName, "$($invokeParams.Method) $uri with $($invokeParams.Body)")) { return }
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue creating report [$ReportName]"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                [Thycotic.PowerShell.Reports.Report]$restResponse
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}