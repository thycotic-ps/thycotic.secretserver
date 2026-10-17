function Get-TssRoleUnassignedPermission {
    <#
    .SYNOPSIS
    Get the permissions not assigned to any role

    .DESCRIPTION
    Returns the name of every permission that no role has, one string per permission.
    Secret Server never returns Web Services Impersonate or the four Privilege Manager permissions here, even when no role has them.
    Useful after an upgrade to find new permissions that no role has been given yet.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssRoleUnassignedPermission -TssSession $session

    Returns the names of permissions no role has

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/roles/Get-TssRoleUnassignedPermission

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/roles/Get-TssRoleUnassignedPermission.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('System.String')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'rolepermissions', 'unassigned' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssRoleUnassignedPermission request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.permissions) {
                $restResponse.permissions
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
