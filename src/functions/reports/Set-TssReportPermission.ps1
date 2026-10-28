function Set-TssReportPermission {
    <#
    .SYNOPSIS
    Set the permissions of a report

    .DESCRIPTION
    Set the explicit permissions of a report, or whether it inherits permissions from its report category.
    The permissions given replace the report's whole permission list; Clear removes every explicit permission.
    Each GroupId gets the matching RolePermissionId, or the single RolePermissionId when only one is given.
    Turning inheritance on also removes every explicit permission from the report.
    Use Search-TssReportPermission -Options for the role permission IDs.
    Returns the permissions of the report after the change.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Report ID

    .PARAMETER GroupId
    Group IDs (a user's personal group for a user) to grant a permission

    .PARAMETER RolePermissionId
    Role permission ID for each GroupId, or one ID for all of them

    .PARAMETER Clear
    Remove every explicit permission from the report

    .PARAMETER EnableInheritPermissions
    Inherit permissions from the report category, which removes the explicit permissions; -EnableInheritPermissions:$false stops inheriting

    .PARAMETER AllowRemoveEdit
    Allow the change to remove the edit permission of the current user

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssReportPermission -TssSession $session -Id 60 -EnableInheritPermissions

    Makes report 60 inherit permissions from its report category and removes its explicit permissions

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $view = Search-TssReportPermission -TssSession $session -Options | Where-Object RolePermissionName -like '*View*'
    Set-TssReportPermission -TssSession $session -Id 60 -GroupId 25 -RolePermissionId $view.RolePermissionId -EnableInheritPermissions:$false -AllowRemoveEdit

    Stops report 60 inheriting permissions and replaces its permissions with the view permission for group 25

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Set-TssReportPermission

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Set-TssReportPermission.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'inherit')]
    [OutputType('Thycotic.PowerShell.Reports.Permission[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ReportId')]
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

        [Parameter(ParameterSetName = 'grant')]
        [Parameter(ParameterSetName = 'clear')]
        [Parameter(Mandatory, ParameterSetName = 'inherit')]
        [switch]
        $EnableInheritPermissions,

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
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'reports', $Id, 'permissions' -join '/'
            $invokeParams.Uri = $uri, "take=$($TssSession.Take)" -join '?'
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ allowRemoveEdit = [boolean]$AllowRemoveEdit } }
            if ($tssParams.ContainsKey('EnableInheritPermissions')) {
                $body.data.Add('enableInheritPermissions', @{ dirty = $true; value = [boolean]$EnableInheritPermissions })
            }
            if ($PSCmdlet.ParameterSetName -ne 'inherit') {
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
                $body.data.Add('permissions', @{ dirty = $true; value = $permissions })
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Report Id: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue setting permissions of report [$Id]"
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
