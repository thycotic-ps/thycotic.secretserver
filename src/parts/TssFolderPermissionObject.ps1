<#
    .Synopsis
        Creates a TssFolderPermission object
#>
param(
    [pscustomobject]$Object
)

begin {
    $Properties = $Object[0].PSObject.Properties.Name
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
            $outObject += $currentObject
        }
        return $outObject
    }