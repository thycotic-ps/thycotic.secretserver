function Update-TssExternalVaultPermission {
    <#
    .SYNOPSIS
    Update the permissions of an external vault

    .DESCRIPTION
    Add, change or remove user and group permissions on an external vault. Permissions not passed are left as they are.
    -Permission takes the records Search-TssExternalVaultPermission returns, edited, or new ones built from the Permission type with a GroupId or a UserId. Every permission flag of a record is sent, so a flag left false is removed.
    The output is True when the server applied the update.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    External vault ID

    .PARAMETER Permission
    Permissions to add or change, as returned by Search-TssExternalVaultPermission

    .PARAMETER RemoveGroupId
    IDs of groups whose permissions to remove

    .PARAMETER RemoveUserId
    IDs of users whose permissions to remove

    .PARAMETER CanRemoveSelfAccess
    Allow the update to remove your own access

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $permission = Search-TssExternalVaultPermission -TssSession $session -Id 3 -SearchText 'Vault Admins'
    $permission.EditVault = $true
    Update-TssExternalVaultPermission -TssSession $session -Id 3 -Permission $permission

    Give the Vault Admins group the EditVault permission on external vault 3, keeping its other permissions

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $permission = [Thycotic.PowerShell.ExternalVaults.Permission]@{ GroupId = 7; ViewExternalSecret = $true }
    Update-TssExternalVaultPermission -TssSession $session -Id 3 -Permission $permission

    Give group 7 the ViewExternalSecret permission on external vault 3

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssExternalVaultPermission -TssSession $session -Id 3 -RemoveGroupId 7

    Remove the permissions of group 7 from external vault 3

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Update-TssExternalVaultPermission

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Update-TssExternalVaultPermission.ps1

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
        [Alias('ExternalVaultId')]
        [int]
        $Id,

        [Thycotic.PowerShell.ExternalVaults.Permission[]]
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
            $uri = $TssSession.ApiUrl, 'external-vaults', 'vaults', $Id, 'permissions' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $updateItems = foreach ($entry in $Permission) {
                $item = @{
                    createSecret                  = $entry.CreateSecret
                    editExternalSecret            = $entry.EditExternalSecret
                    editExternalSecretPermissions = $entry.EditExternalSecretPermissions
                    editVault                     = $entry.EditVault
                    editVaultPermissions          = $entry.EditVaultPermissions
                    pull                          = $entry.Pull
                    push                          = $entry.Push
                    setExternalSecretRemoteValue  = $entry.SetExternalSecretRemoteValue
                    viewExternalSecret            = $entry.ViewExternalSecret
                    viewExternalSecretRemoteValue = $entry.ViewExternalSecretRemoteValue
                    viewExternalValues            = $entry.ViewExternalValues
                    viewVault                     = $entry.ViewVault
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
            if ($PSCmdlet.ShouldProcess("External vault permission: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssExternalVaultPermission request'
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
