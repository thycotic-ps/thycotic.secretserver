function Search-TssReportCategoryPermission {
    <#
    .SYNOPSIS
    Search the permissions of a report category

    .DESCRIPTION
    Search the permissions of a report category: each entry is a user or group and the role permission it holds on the category.
    With Options it lists the role permissions that can be granted on a report category instead.
    Returns up to the session's Take value of entries per category.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Report category ID

    .PARAMETER Options
    List the role permissions that can be granted on a report category

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssReportCategoryPermission -TssSession $session -Id 3

    Returns the permissions of report category 3

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssReportCategoryPermission -TssSession $session -Options

    Returns the role permissions (RolePermissionId and RolePermissionName) that can be granted on a report category

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Search-TssReportCategoryPermission

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Search-TssReportCategoryPermission.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'category')]
    [OutputType('Thycotic.PowerShell.Reports.Permission[]', ParameterSetName = 'category')]
    [OutputType('Thycotic.PowerShell.Reports.PermissionOption[]', ParameterSetName = 'options')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'category')]
        [Alias('ReportCategoryId')]
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
                $uri = $TssSession.ApiUrl, 'reports', 'categories', 'permissions', 'options' -join '/'
                $invokeParams.Uri = $uri
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Search-TssReportCategoryPermission request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Reports.PermissionOption[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Reports.PermissionOption]))
                }
            } else {
                foreach ($currentId in $Id) {
                    $restResponse = $null
                    $uri = $TssSession.ApiUrl, 'reports', 'categories', $currentId, 'permissions' -join '/'
                    $uri = $uri, "take=$($TssSession.Take)" -join '?'
                    $invokeParams.Uri = $uri
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue getting permissions of report category [$currentId]"
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
