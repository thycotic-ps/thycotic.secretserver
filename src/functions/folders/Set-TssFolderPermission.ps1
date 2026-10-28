function Set-TssFolderPermission {
    <#
    .SYNOPSIS
    Add, update or remove permissions on a folder in one call

    .DESCRIPTION
    Applies a subset of permission changes to a folder: users or groups in AddOrUpdateItems are granted or updated, users or groups in RemoveItems are removed, and existing permissions not named are left as they are.
    With InheritPermissions set to true every other change is ignored and the folder goes back to inheriting permissions from its parent. With InheritPermissions set to false inheritance is broken first and then the changes are applied.
    A top-level folder cannot be set to inherit permissions, and personal folders do not allow inheritance changes.
    Use New-TssFolderPermission or Update-TssFolderPermission to manage a single permission row by name.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Folder ID

    .PARAMETER AddOrUpdateItems
    Permissions to add or update, each a hashtable or object with userId or groupId (groupId wins when both are set), folderAccessRoleId, secretAccessRoleId, and optionally editDependencies and manageTotp. Role IDs are integers, as returned by Get-TssFolderPermission (FolderAccessRoleId, SecretAccessRoleId)

    .PARAMETER AllowRemoveOwner
    Allow the change to remove the current user's own edit access to the folder. Without it the request fails when it would do so

    .PARAMETER InheritPermissions
    True resets the folder to inherit permissions and ignores the other changes. False breaks inheritance and then applies the changes

    .PARAMETER RemoveItems
    Users or groups to remove from the folder permissions, each a hashtable or object with userId or groupId

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssFolderPermission -TssSession $session -Id 42 -InheritPermissions:$false -AddOrUpdateItems @{ groupId = 3; folderAccessRoleId = 12; secretAccessRoleId = 12 }

    Breaks inheritance on folder 42 and grants group 3 the folder and secret roles with ID 12

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssFolderPermission -TssSession $session -Id 42 -RemoveItems @{ userId = 5 }, @{ groupId = 7 }

    Removes user 5 and group 7 from the permissions on folder 42

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssFolderPermission -TssSession $session -Id 42 -InheritPermissions

    Resets folder 42 to inherit permissions from its parent folder

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Set-TssFolderPermission

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Set-TssFolderPermission.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Folders.ActionResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('FolderId')]
        [int]
        $Id,

        [object[]]
        $AddOrUpdateItems,

        [switch]
        $AllowRemoveOwner,

        [switch]
        $InheritPermissions,

        [object[]]
        $RemoveItems
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'folder', $Id, 'permissions' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{
                data = @{
                    addOrUpdateItems = @($AddOrUpdateItems | Where-Object { $_ })
                    removeItems      = @($RemoveItems | Where-Object { $_ })
                }
            }
            switch ($tssParams.Keys) {
                'AllowRemoveOwner' {
                    $body.data.Add('allowRemoveOwner', [boolean]$AllowRemoveOwner)
                }
                'InheritPermissions' {
                    $body.data.Add('inheritPermissions', @{ dirty = $true; value = [boolean]$InheritPermissions })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Folder permission: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssFolderPermission request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Folders.ActionResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Folders.ActionResult]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
