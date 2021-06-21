function New-Report {
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
    >> ReportName = 'Tss Test Report from SQL File'
    >> Category = (Get-TssReportCategory -TssSession $session -All | Where-Object Name -eq 'TssCategory').CategoryId
    >> Description = 'Test report using SQL file'
    >> ReportSql = (Get-Content .\tests\exports\testReport.sql | Out-String)
    >> }
    New-TssReport -TssSession $session @params

    Create a new report where the T-SQL is stored in a SQL script file

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/New-TssReport

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/New-Report.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('TssReport')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [TssSession]
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
        $invokeParams = . $GetInvokeTssParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssNewReportParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
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

            Write-Verbose "$($invokeParams.Method) $uri with:`n $newReportBody"
            if (-not $PSCmdlet.ShouldProcess($ReportName, "$($invokeParams.Method) $uri with $($invokeParams.Body)")) { return }
            try {
                $restResponse = . $InvokeApi @invokeParams
            } catch {
                Write-Warning "Issue creating report [$ReportName]"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                [TssReport]$restResponse
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}