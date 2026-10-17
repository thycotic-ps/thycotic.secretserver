function Set-TssReportCategoryPermission {
    <#
    .SYNOPSIS
    Set the permissions of a report category

    .DESCRIPTION
    Set the explicit permissions of a report category.
    The permissions given replace the category's whole permission list; Clear removes every explicit permission.
    Each GroupId gets the matching RolePermissionId, or the single RolePermissionId when only one is given.
    Use Search-TssReportCategoryPermission -Options for the role permission IDs.
    Returns the permissions of the category after the change.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Report category ID

    .PARAMETER GroupId
    Group IDs (a user's personal group for a user) to grant a permission

    .PARAMETER RolePermissionId
    Role permission ID for each GroupId, or one ID for all of them

    .PARAMETER Clear
    Remove every explicit permission from the report category

    .PARAMETER AllowRemoveEdit
    Allow the change to remove the edit permission of the current user

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $view = Search-TssReportCategoryPermission -TssSession $session -Options | Where-Object RolePermissionName -like '*View*'
    Set-TssReportCategoryPermission -TssSession $session -Id 3 -GroupId 25, 79 -RolePermissionId $view.RolePermissionId -AllowRemoveEdit

    Replaces the permissions of report category 3 with the view permission for groups 25 and 79

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssReportCategoryPermission -TssSession $session -Id 3 -Clear -AllowRemoveEdit

    Removes every explicit permission from report category 3

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Set-TssReportCategoryPermission

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Set-TssReportCategoryPermission.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'grant')]
    [OutputType('Thycotic.PowerShell.Reports.Permission[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ReportCategoryId')]
        [int]
        $Id,

        [Parameter(Mandatory, ParameterSetName = 'grant')]
        [int[]]
        $GroupId,

        [Parameter(Mandatory, ParameterSetName = 'grant')]
        [int[]]
        $RolePermissionId,

        [Parameter(Mandatory, ParameterSetName = 'clear')]
        [switch]
        $Clear,

        [switch]
        $AllowRemoveEdit
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $permissions = @()
            if ($PSCmdlet.ParameterSetName -eq 'grant') {
                if ($RolePermissionId.Count -ne 1 -and $RolePermissionId.Count -ne $GroupId.Count) {
                    Write-Error 'Provide one RolePermissionId, or one RolePermissionId for each GroupId'
                    return
                }
                for ($i = 0; $i -lt $GroupId.Count; $i++) {
                    $permissions += @{
                        groupId          = $GroupId[$i]
                        rolePermissionId = if ($RolePermissionId.Count -eq 1) { $RolePermissionId[0] } else { $RolePermissionId[$i] }
                    }
                }
            }
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'reports', 'categories', $Id, 'permissions' -join '/'
            $invokeParams.Uri = $uri, "take=$($TssSession.Take)" -join '?'
            $invokeParams.Method = 'PATCH'
            $body = @{
                data = @{
                    allowRemoveEdit = [boolean]$AllowRemoveEdit
                    permissions     = @{ dirty = $true; value = $permissions }
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Report category: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue setting permissions of report category [$Id]"
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
