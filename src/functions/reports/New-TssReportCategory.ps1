function New-TssReportCategory {
    <#
    .SYNOPSIS
    Create a new report category

    .DESCRIPTION
    Create a new report category.
    Without SortOrder the category is added at the end of the category list.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Name
    Name of the report category

    .PARAMETER Description
    Description of the report category

    .PARAMETER SortOrder
    Position of the category in the category list

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssReportCategory -TssSession $session -Name 'Audit Reports' -Description 'Reports for the audit team'

    Creates the report category "Audit Reports" at the end of the category list

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssReportCategory -TssSession $session -Name 'Rotation' -Description 'Password rotation reports' -SortOrder 1

    Creates the report category "Rotation" with sort order 1

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/New-TssReportCategory

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/New-TssReportCategory.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Reports.CategoryDetail')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ReportCategoryName')]
        [string]
        $Name,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ReportCategoryDescription')]
        [string]
        $Description,

        [Parameter(ValueFromPipelineByPropertyName)]
        [int]
        $SortOrder
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
            $uri = $TssSession.ApiUrl, 'reports', 'categories' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ reportCategoryName = $Name; reportCategoryDescription = $Description } }
            switch ($tssParams.Keys) {
                'SortOrder' {
                    $body.data.Add('sortOrder', $SortOrder)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Report category: $Name", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue creating report category [$Name]"
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Reports.CategoryDetail](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Reports.CategoryDetail]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
