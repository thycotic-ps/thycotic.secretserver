<#
    .Synopsis
        Creates a TssFolderPermission object
#>
param(
    [pscustomobject]$Object
)

begin {
    $Properties = $Object[0].PSObject.Properties.Name

    <# Hashtables for Folder Access Role Name #>
    $folderAccessRoles = @{
        6  = 'Add Secret'
        7  = 'Edit'
        10 = 'Owner'
        12 = 'View'
    }
    <# Hashtables for Secret Access Role Name #>
    $secretAccessRoles = @{
        8  = 'Edit'
        9  = 'List'
        11 = 'Owner'
        13 = 'View'
    }
}

process {
    $outObject = @()
    foreach ($f in $Object) {
        $currentObject = [TssFolderPermission]::new()
        foreach ($sProp in $Properties) {
            # until bug is fixed in endpoint
            if ($sProp -in 'Id','folderId','folderAccessRoleName','SecretAccessRoleName','groupName','userId','userName','knownAs') {
                continue
            }
            if ($sProp -in $currentObject.PSObject.Properties.Name) {
                $currentObject.$sProp = $f.$sProp
            } else {
                Write-Warning "Property $sProp does not exist in the TssFolderPermission class.bug report at https://github.com/thycotic-ps/thycotic.secretserver/issues/new/choose"
            }
        }
        # Set FolderAccessRoleName
        $currentObject.FolderAccessRoleName = $folderAccessRoles[[int]$f.FolderAccessRoleId]

        # Set SecretAccessRoleName
        $currentObject.SecretAccessRoleName = $secretAccessRoles[[int]$f.SecretAccessRoleId]

        $outObject += $currentObject
    }
    return $outObject
}