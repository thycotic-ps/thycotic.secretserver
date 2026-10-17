function Invoke-TssBulkUserAction {
    <#
    .SYNOPSIS
    Run a bulk action on users

    .DESCRIPTION
    Run one bulk action on one or more users: lock, unlock, enable, disable, force logout, or add to or remove from a group or team.
    Each call sends one request for all the users passed to -Id. Set-TssUserTwoFactor runs the two-factor bulk actions.
    The operation runs in the background: pipe the output (BulkOperationId is the task identifier) to Get-TssBulkOperationProgress to follow it.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    IDs of the users to act on

    .PARAMETER Action
    Bulk action to run: Lock, Unlock, Enable, Disable, ForceLogout, AddToGroup, RemoveFromGroup, AddToTeam, RemoveFromTeam

    .PARAMETER GroupId
    Group ID, required by AddToGroup and RemoveFromGroup

    .PARAMETER TeamId
    Team ID, required by AddToTeam and RemoveFromTeam

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Invoke-TssBulkUserAction -TssSession $session -Id 12, 13 -Action Lock

    Lock users 12 and 13

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Invoke-TssBulkUserAction -TssSession $session -Id 12, 13 -Action AddToGroup -GroupId 5

    Add users 12 and 13 to group 5

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/bulk-user-operations/Invoke-TssBulkUserAction

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/bulk-user-operations/Invoke-TssBulkUserAction.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.BulkOperations.Response')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [Alias('UserId')]
        [int[]]
        $Id,

        [Parameter(Mandatory)]
        [ValidateSet('Lock', 'Unlock', 'Enable', 'Disable', 'ForceLogout', 'AddToGroup', 'RemoveFromGroup', 'AddToTeam', 'RemoveFromTeam')]
        [string]
        $Action,

        [int]
        $GroupId,

        [int]
        $TeamId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        if ($Action -in 'AddToGroup', 'RemoveFromGroup' -and -not $tssParams.ContainsKey('GroupId')) {
            Write-Error "GroupId is required for action $Action"
            return
        }
        if ($Action -in 'AddToTeam', 'RemoveFromTeam' -and -not $tssParams.ContainsKey('TeamId')) {
            Write-Error "TeamId is required for action $Action"
            return
        }
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.2.000004' $PSCmdlet.MyInvocation
            switch ($Action) {
                'Lock' {
                    $uri = $TssSession.ApiUrl, 'bulk-user-operations', 'lock' -join '/'
                }
                'Unlock' {
                    $uri = $TssSession.ApiUrl, 'bulk-user-operations', 'unlock' -join '/'
                }
                'Enable' {
                    $uri = $TssSession.ApiUrl, 'bulk-user-operations', 'enable' -join '/'
                }
                'Disable' {
                    $uri = $TssSession.ApiUrl, 'bulk-user-operations', 'disable' -join '/'
                }
                'ForceLogout' {
                    $uri = $TssSession.ApiUrl, 'bulk-user-operations', 'force-logout' -join '/'
                }
                'AddToGroup' {
                    $uri = $TssSession.ApiUrl, 'bulk-user-operations', 'add-to-group' -join '/'
                }
                'RemoveFromGroup' {
                    $uri = $TssSession.ApiUrl, 'bulk-user-operations', 'remove-from-group' -join '/'
                }
                'AddToTeam' {
                    $uri = $TssSession.ApiUrl, 'bulk-user-operations', 'add-to-team' -join '/'
                }
                'RemoveFromTeam' {
                    $uri = $TssSession.ApiUrl, 'bulk-user-operations', 'remove-from-team' -join '/'
                }
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ userIds = $Id } }
            if ($Action -in 'AddToGroup', 'RemoveFromGroup') {
                $body.data.Add('groupId', $GroupId)
            }
            if ($Action -in 'AddToTeam', 'RemoveFromTeam') {
                $body.data.Add('teamId', $TeamId)
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("User IDs: $($Id -join ', ')", "$Action with $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Invoke-TssBulkUserAction request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.BulkOperations.Response](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.BulkOperations.Response]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
