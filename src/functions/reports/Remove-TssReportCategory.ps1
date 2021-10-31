function Remove-TssReportCategory {
    <#
    .SYNOPSIS
    Delete a report category

    .DESCRIPTION
    Deletes the report category, associated reports are changed to inactive and moved to the Delete category

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssReportCategory -TssSession $session -Id 11

    A confirmation prompt will be shown.
    Removes report category 11

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssReportCategory -TssSession $session -Id 21 -Confirm:$false

    Confirmation prompt is bypassed
    Removes report category 21

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Remove-TssReportCategory

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Remove-TssReportCategory.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    [OutputType('Thycotic.PowerShell.Common.Delete')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Category ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('Id')]
        [int[]]
        $ReportCategoryId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }

    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($category in $ReportCategoryId) {
                $uri = $TssSession.ApiUrl, 'reports/categories', $category -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'DELETE'


                Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
                if ($PSCmdlet.ShouldProcess("RemoteCategoryId: $category", "$($invokeParams.Method) $($invokeParams.Uri)")) {
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue removing [$category]"
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if ($restResponse) {
                        [Thycotic.PowerShell.Common.Delete]$restResponse
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}