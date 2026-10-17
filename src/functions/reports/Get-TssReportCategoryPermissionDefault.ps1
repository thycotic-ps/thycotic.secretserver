function Get-TssReportCategoryPermissionDefault {
    <#
    .SYNOPSIS
    Get the report permissions a report category passes down

    .DESCRIPTION
    Get the permissions a report inherits from a report category: the permissions a report in that category gets when it inherits permissions.
    Returns up to the session's Take value of entries per category.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Report category ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssReportCategoryPermissionDefault -TssSession $session -Id 3

    Returns the permissions a report placed in report category 3 inherits

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Get-TssReportCategoryPermissionDefault

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Get-TssReportCategoryPermissionDefault.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Reports.Permission[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ReportCategoryId')]
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
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'reports', $currentId, 'permissions-from-category' -join '/'
                $uri = $uri, "take=$($TssSession.Take)" -join '?'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue getting inherited permissions of report category [$currentId]"
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.records) {
                    [Thycotic.PowerShell.Reports.Permission[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Reports.Permission]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
