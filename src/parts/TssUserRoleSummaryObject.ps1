<#
    .Synopsis
        Creates a TssUserRoleSummary object
#>
param(
    [pscustomobject]$Object
)

begin {
    $Properties = $Object[0].PSObject.Properties.Name
    if ($object.groups) {
        $groupProperties = $Object.groups[0].PSObject.Properties.Name
    } else {
        Write-Verbose "No groups found on records object"
    }
}

process {
    if ($groupProperties) {
        $groups = @()
        foreach ($g in $Object.groups) {
            $group = [TssGroupAssignedRole]::new()
            foreach ($iProp in $groupProperties) {
                if ($iProp -in $group.PSObject.Properties.Name) {
                    $group.$iProp = $g.$iProp
                } else {
                    Write-Warning "Property $iProp does not exist in the TssGroupAssignedRole class. Please create a bug report at https://github.com/thycotic-ps/thycotic.secretserver/issues/new/choose"
                }
                $groups += $group
            }
        }
    }

    $outObject = @()
    foreach ($r in $Object) {
        $currentObject = [TssUserRoleSummary]::new()
        foreach ($sProp in $Properties) {
            if ($sProp -eq 'groups' -and $groups) {
                $currentObject.Groups = $groups
            }
            if ($sProp -in $currentObject.PSObject.Properties.Name) {
                $currentObject.$sProp = $r.$sProp
            } else {
                Write-Warning "Property $sProp does not exist in the TssUserRoleSummary class. Please create a bug report at https://github.com/thycotic-ps/thycotic.secretserver/issues/new/choose"
            }
        }
        $outObject += $currentObject
    }
    return $outObject
}