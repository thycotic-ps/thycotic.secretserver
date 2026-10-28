function Search-TssRolePermission {
    <#
    .SYNOPSIS
    Search the permissions of a role

    .DESCRIPTION
    Returns the permissions assigned to a role.
    With -Eligible, returns every permission the role type allows. With -Unassigned, returns the allowed permissions the role does not have.
    Pass RolePermissionId values to Update-TssRolePermission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Role ID

    .PARAMETER Eligible
    Return every permission the role type allows (GET api/v1/roles/{id}/permissions/eligible)

    .PARAMETER Unassigned
    Return the permissions the role type allows that the role does not have (GET api/v1/roles/{id}/permissions/unassigned)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssRolePermission -TssSession $session -Id 7

    Returns the permissions assigned to role ID 7

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssRolePermission -TssSession $session -Id 7 -Unassigned

    Returns the permissions role ID 7 could have but does not

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/roles/Search-TssRolePermission

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/roles/Search-TssRolePermission.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    [OutputType('Thycotic.PowerShell.Roles.Permission[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('RoleId')]
        [int[]]
        $Id,

        [Parameter(Mandatory, ParameterSetName = 'Eligible')]
        [switch]
        $Eligible,

        [Parameter(Mandatory, ParameterSetName = 'Unassigned')]
        [switch]
        $Unassigned
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
                switch ($PSCmdlet.ParameterSetName) {
                    'Eligible' {
                        $uri = $TssSession.ApiUrl, 'roles', $currentId, 'permissions', 'eligible' -join '/'
                        $queryParams = @()
                        $queryParams += "take=$($TssSession.Take)"
                        if ($queryParams) {
                            $uri = $uri, ($queryParams -join '&') -join '?'
                        }
                    }
                    'Unassigned' {
                        $uri = $TssSession.ApiUrl, 'roles', $currentId, 'permissions', 'unassigned' -join '/'
                        $queryParams = @()
                        $queryParams += "take=$($TssSession.Take)"
                        if ($queryParams) {
                            $uri = $uri, ($queryParams -join '&') -join '?'
                        }
                    }
                    default {
                        $uri = $TssSession.ApiUrl, 'roles', $currentId, 'permissions' -join '/'
                        $queryParams = @()
                        $queryParams += "take=$($TssSession.Take)"
                        if ($queryParams) {
                            $uri = $uri, ($queryParams -join '&') -join '?'
                        }
                    }
                }
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Search-TssRolePermission request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.records) {
                    [Thycotic.PowerShell.Roles.Permission[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Roles.Permission]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
