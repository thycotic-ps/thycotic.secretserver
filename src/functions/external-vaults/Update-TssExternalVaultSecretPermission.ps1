function Update-TssExternalVaultSecretPermission {
    <#
    .SYNOPSIS
    Update the permissions of an external vault secret

    .DESCRIPTION
    Add, change or remove user and group permissions on an external vault secret. Permissions not passed are left as they are.
    -Permission takes the records Search-TssExternalVaultSecretPermission returns, edited, or new ones built from the SecretPermission type with a GroupId or a UserId. Every permission flag of a record is sent, so a flag left false is removed.
    The output is True when the server applied the update.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    External vault secret ID

    .PARAMETER Permission
    Permissions to add or change, as returned by Search-TssExternalVaultSecretPermission

    .PARAMETER RemoveGroupId
    IDs of groups whose permissions to remove

    .PARAMETER RemoveUserId
    IDs of users whose permissions to remove

    .PARAMETER CanRemoveSelfAccess
    Allow the update to remove your own access

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $permission = Search-TssExternalVaultSecretPermission -TssSession $session -Id 12 -SearchText 'Vault Admins'
    $permission.EditExternalSecret = $true
    Update-TssExternalVaultSecretPermission -TssSession $session -Id 12 -Permission $permission

    Give the Vault Admins group the EditExternalSecret permission on external vault secret 12, keeping its other permissions

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $permission = [Thycotic.PowerShell.ExternalVaults.SecretPermission]@{ GroupId = 7; ViewExternalSecret = $true }
    Update-TssExternalVaultSecretPermission -TssSession $session -Id 12 -Permission $permission

    Give group 7 the ViewExternalSecret permission on external vault secret 12

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssExternalVaultSecretPermission -TssSession $session -Id 12 -RemoveGroupId 7

    Remove the permissions of group 7 from external vault secret 12

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Update-TssExternalVaultSecretPermission

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Update-TssExternalVaultSecretPermission.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('System.Boolean')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ExternalVaultSecretId')]
        [int]
        $Id,

        [Thycotic.PowerShell.ExternalVaults.SecretPermission[]]
        $Permission,

        [int[]]
        $RemoveGroupId,

        [int[]]
        $RemoveUserId,

        [switch]
        $CanRemoveSelfAccess
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.7.000000' $PSCmdlet.MyInvocation
            if (-not ($tssParams.ContainsKey('Permission') -or $tssParams.ContainsKey('RemoveGroupId') -or $tssParams.ContainsKey('RemoveUserId'))) {
                Write-Error 'Pass -Permission, -RemoveGroupId or -RemoveUserId'
                return
            }
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'external-vaults', 'vaults', 'secrets', $Id, 'permissions' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $updateItems = foreach ($entry in $Permission) {
                $item = @{
                    editExternalSecret            = $entry.EditExternalSecret
                    editExternalSecretPermissions = $entry.EditExternalSecretPermissions
                    push                          = $entry.Push
                    setExternalSecretRemoteValue  = $entry.SetExternalSecretRemoteValue
                    viewExternalSecret            = $entry.ViewExternalSecret
                    viewExternalSecretRemoteValue = $entry.ViewExternalSecretRemoteValue
                }
                if ($entry.GroupId -gt 0) {
                    $item.groupId = $entry.GroupId
                } elseif ($entry.UserId -gt 0) {
                    $item.userId = $entry.UserId
                } else {
                    Write-Error 'Each -Permission entry needs a GroupId or a UserId'
                    return
                }
                $item
            }
            $removeItems = @(
                foreach ($groupId in $RemoveGroupId) { @{ groupId = $groupId } }
                foreach ($userId in $RemoveUserId) { @{ userId = $userId } }
            )
            $body = @{
                data = @{
                    canRemoveSelfAccess = [boolean]$CanRemoveSelfAccess
                    updateItems         = @($updateItems)
                    removeItems         = $removeItems
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("External vault secret permission: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssExternalVaultSecretPermission request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($null -ne $restResponse) {
                    [boolean]$restResponse.success
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
