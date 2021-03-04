<#
    .Synopsis
        Creates a TssCurrentUser object
#>
param(
    [pscustomobject]$Object
)

begin {
    $Properties = $Object[0].PSObject.Properties.Name
    if ($Object.adminLinks) {
        $adminLinksProps = $Object.adminLinks[0].PSObject.Properties.Name
    } else {
        Write-Verbose "No adminLinks property found on records object"
    }
    if ($Object.profileLinks) {
        $profileLinksProps = $Object.profileLinks[0].PSObject.Properties.Name
    } else {
        Write-Verbose "No adminLinks property found on records object"
    }
    if ($Object.permissions) {
        $permissionProps = $Object.permissions[0].PSObject.Properties.Name
    } else {
        Write-Verbose "No adminLinks property found on records object"
    }
}
process {
    if ($adminLinksProps) {
        $adminLinks = @()
        foreach ($al in $Object.adminLinks) {
            $adminLink = [TssMenuLink]::new()
            foreach ($cProp in $adminLinksProps) {
                if ($cProp -in $adminLink.PSObject.Properties.Name) {
                    $adminLink.$cProp = $al.$cProp
                } else {
                    Write-Warning "Property $cProp does not exist in the TssMenuLink property class. Please create a bug report at https://github.com/thycotic-ps/thycotic.secretserver/issues/new/choose"
                }
                $adminLinks += $adminLink
            }
        }
    }
    if ($profileLinksProps) {
        $profileLinks = @()
        foreach ($pl in $Object.profileLinks) {
            $profileLink = [TssMenuLink]::new()
            foreach ($cProp in $profileLinksProps) {
                if ($cProp -in $profileLink.PSObject.Properties.Name) {
                    $profileLink.$cProp = $pl.$cProp
                } else {
                    Write-Warning "Property $cProp does not exist in the TssMenuLink property class. Please create a bug report at https://github.com/thycotic-ps/thycotic.secretserver/issues/new/choose"
                }
                $profileLinks += $profileLink
            }
        }
    }
    if ($permissionProps) {
        $permissions = @()
        foreach ($p in $Object.permissions) {
            $permission = [TssRolePermission]::new()
            foreach ($cProp in $permissionProps) {
                if ($cProp -in $permission.PSObject.Properties.Name) {
                    $permission.$cProp = $p.$cProp
                } else {
                    Write-Warning "Property $cProp does not exist in the TssMenuLink property class. Please create a bug report at https://github.com/thycotic-ps/thycotic.secretserver/issues/new/choose"
                }
                $permissions += $permission
            }
        }
    }

    $outObject = @()
    foreach ($p in $Object) {
        $currentObject = [TssCurrentUser]::new()
        foreach ($pProp in $Properties) {
            if ($pProp -eq 'adminLinks') {
                $currentObject.adminLinks = $adminLinks
            }
            if ($pProp -eq 'profileLinks') {
                $currentObject.profileLinks = $profileLinks
            }
            if ($pProp -eq 'permissions') {
                $currentObject.permissions = $permissions
            }
            if ($pProp -in $currentObject.PSObject.Properties.Name) {
                $currentObject.$pProp = $p.$pProp
            } else {
                Write-Warning "Property $pProp does not exist in the TssCurrentUser class. Please create a bug report at https://github.com/thycotic-ps/thycotic.secretserver/issues/new/choose"
            }
        }
        $outObject += $currentObject
    }
    return $outObject
}