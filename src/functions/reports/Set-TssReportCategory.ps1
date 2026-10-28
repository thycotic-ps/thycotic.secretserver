function Set-TssReportCategory {
    <#
    .SYNOPSIS
    Set the name or description of a report category

    .DESCRIPTION
    Set the name or description of a report category.
    Only the parameters provided are changed.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Report category ID

    .PARAMETER Name
    New name of the report category

    .PARAMETER Description
    New description of the report category

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssReportCategory -TssSession $session -Id 12 -Description 'Reports for the audit team'

    Sets the description of report category 12, leaving its name unchanged

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssReportCategory -TssSession $session -Id 12 -Name 'Audit' -Description 'Reports for the audit team'

    Renames report category 12 to "Audit" and sets its description

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Set-TssReportCategory

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Set-TssReportCategory.ps1

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
        [Alias('ReportCategoryId')]
        [int]
        $Id,

        [Alias('ReportCategoryName')]
        [string]
        $Name,

        [Alias('ReportCategoryDescription')]
        [string]
        $Description
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
            $uri = $TssSession.ApiUrl, 'reports', 'categories', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Name' {
                    $body.data.Add('reportCategoryName', @{ dirty = $true; value = $Name })
                }
                'Description' {
                    $body.data.Add('reportCategoryDescription', @{ dirty = $true; value = $Description })
                }
            }
            if ($body.data.Count -eq 0) {
                Write-Error 'Provide Name or Description to update'
                return
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Report category: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue updating report category [$Id]"
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
