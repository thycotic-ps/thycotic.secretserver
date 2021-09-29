function Get-TssReportCategory {
    <#
    .SYNOPSIS
    Get report categories

    .DESCRIPTION
    Get a report category by Id or list all

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssReportCategory -TssSession $session -Id 26

    Returns Report Category details for 26

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssReportCategory -TssSession $session

    Returns a list of all categories

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Get-TssReportCategory

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Get-TssReportCategory.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Reports.Category')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Report Category Id, returns all if not provided
        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('ReportCategoryId')]
        [int[]]
        $Id,

        # Return list of all categories
        [Parameter()]
        [switch]
        $All
    )
    begin {
        $tssReportCatParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssReportCatParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            if ($tssReportCatParams['Id']) {
                foreach ($reportCategory in $Id) {
                    $restResponse = $null
                    $uri = $TssSession.ApiUrl, 'reports/categories', $reportCategory -join '/'
                    $invokeParams.Uri = $uri
                    $invokeParams.Method = 'GET'

                    Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue getting details on [$reportCategory]"
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if ($restResponse) {
                        [TssReportCategoryDetail]$restResponse
                    }
                }
            }
            if ($tssReportCatParams['All']) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'reports/categories' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue getting details on [$reportCategory]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    [Thycotic.PowerShell.Reports.Category[]]$restResponse.model
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}