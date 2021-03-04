class TssMenuLink {
    [string]
    $Link

    [string]
    $Name
}

class TssRolePermission {
    [string]
    $Name
}

class TssCurrentUser {
    [TssMenuLink[]]
    $AdminLinks

    [int]
    $DateOptionId

    [string]
    $DisplayName

    [string]
    $EmailAddress

    [int]
    $Id

    [TssRolePermission[]]
    $Permissions

    [TssMenuLink[]]
    $ProfileLinks

    [int]
    $TimeOptionId

    [int]
    $UserLcid

    [string]
    $Username

    [string]
    $UserTheme

    [TssRolePermission[]] GetPermissions() {
        if ($this.Permissions) {
            $sortedPerms = $this.Permissions | Sort-Object Name
            return $sortedPerms
        } else {
            return "No Permissions found"
        }
    }
}