<#
.Synopsis
    Creates a TssFolder object to output the FolderModel object
.Description
    Creates an instance of the TssFolder class to output the FolderModel and TssFolderTemplate objects
#>
param(
    [pscustomobject]$FolderRecord
)

begin {
    $folderProperties = $FolderRecord.PSObject.Properties.Name
}

process {
    $outFolders = @()
    foreach ($f in $FolderRecord) {
        $outFolder = [TssFolder]::new()
        foreach ($fProp in $folderProperties) {
            if ($fProp -in $outFolder.PSObject.Properties.Name) {
                $outFolder.$fProp = $f.$fProp
            } else {
                Write-Warning "Property $fProp does not exist in the TssFolder class. Please create a bug report at https://github.com/thycotic-ps/thycotic.secretserver/issues/new/choose"
            }
        }
        $outFolders += $outFolder
    }
    return $outFolders
}