function Update-TssRolePermission {
    <#
    .SYNOPSIS
    Replace the permissions assigned to a role

    .DESCRIPTION
    Sets the full list of permissions on a role.
    Permissions not in the list are removed from the role, so pass every permission the role should keep. An empty list removes every permission.
    Get role permission IDs from Search-TssRolePermission with -ErrorAction Stop and the default session Take: a failed or partial read gives a short list, and every permission missing from it is removed.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Role ID

    .PARAMETER RolePermissionId
    Every role permission ID the role should have after the call

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $ids = @((Search-TssRolePermission -TssSession $session -Id 7 -ErrorAction Stop).RolePermissionId)
    $ids += (Search-TssRolePermission -TssSession $session -Id 7 -Unassigned -ErrorAction Stop | Where-Object Name -eq 'View Roles').RolePermissionId
    Update-TssRolePermission -TssSession $session -Id 7 -RolePermissionId $ids

    Adds the View Roles permission to role ID 7 and keeps the permissions it already has

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/roles/Update-TssRolePermission

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/roles/Update-TssRolePermission.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Roles.UpdateResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $Id,

        [Parameter(Mandatory)]
        [AllowEmptyCollection()]
        [Alias('RolePermissionIds')]
        [int[]]
        $RolePermissionId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'roles', $Id, 'permissions' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $body = @{ }
            switch ($tssParams.Keys) {
                'RolePermissionId' {
                    $body.Add('rolePermissionIds', $RolePermissionId)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Role: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssRolePermission request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Roles.UpdateResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Roles.UpdateResult]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
