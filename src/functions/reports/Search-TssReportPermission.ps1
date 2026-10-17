function Search-TssReportPermission {
    <#
    .SYNOPSIS
    Search the permissions of a report

    .DESCRIPTION
    Search the permissions of a report: each entry is a user or group and the role permission it holds on the report.
    With Options it lists the role permissions that can be granted on a report instead.
    Returns up to the session's Take value of entries per report.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Report ID

    .PARAMETER Options
    List the role permissions that can be granted on a report

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssReportPermission -TssSession $session -Id 60

    Returns the permissions of report 60

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssReportPermission -TssSession $session -Options

    Returns the role permissions (RolePermissionId and RolePermissionName) that can be granted on a report

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Search-TssReportPermission

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Search-TssReportPermission.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'report')]
    [OutputType('Thycotic.PowerShell.Reports.Permission[]', ParameterSetName = 'report')]
    [OutputType('Thycotic.PowerShell.Reports.PermissionOption[]', ParameterSetName = 'options')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'report')]
        [Alias('ReportId')]
        [int[]]
        $Id,

        [Parameter(Mandatory, ParameterSetName = 'options')]
        [switch]
        $Options
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $invokeParams.Method = 'GET'
            if ($PSCmdlet.ParameterSetName -eq 'options') {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'reports', 'permissions', 'options' -join '/'
                $invokeParams.Uri = $uri
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Search-TssReportPermission request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Reports.PermissionOption[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Reports.PermissionOption]))
                }
            } else {
                foreach ($currentId in $Id) {
                    $restResponse = $null
                    $uri = $TssSession.ApiUrl, 'reports', $currentId, 'permissions' -join '/'
                    $uri = $uri, "take=$($TssSession.Take)" -join '?'
                    $invokeParams.Uri = $uri
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue getting permissions of report [$currentId]"
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($restResponse.records) {
                        [Thycotic.PowerShell.Reports.Permission[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Reports.Permission]))
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
