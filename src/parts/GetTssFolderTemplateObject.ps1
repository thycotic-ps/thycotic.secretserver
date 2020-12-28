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
    try {
        $folderTemplateProperties = $FolderRecord.secretTemplates[0].PSObject.Properties.Name
    } catch {
        Write-Verbose "No secret templates objects found or IncludeTemplates was not specified"
    }
    try {
        $folderChildrenProperties = $FolderRecord.childFolders[0].PSObject.Properties.Name
    } catch {
        Write-Verbose "No child folders objects found or Recurse was not specified"
    }
}

process {
    $secretTemplates = @()
    foreach ($ft in $FolderRecord.secretTemplates) {
        $fTemplate = [TssFolderTemplate]::new()
        foreach ($tProp in $folderTemplateProperties) {
            $fTemplate.$tProp = $ft.$tProp
        }
        $secretTemplates += $fTemplate
    }
    $childFolders = @()
    foreach ($cf in $FolderRecord.childFolders) {
        $cFolder = [TssFolder]::new()
        foreach ($cProp in $folderChildrenProperties) {
            $cFolder.$cProp = $cf.$cProp
        }
        $childFolders += $cFolder
    }

    foreach ($f in $FolderRecord) {
        $outFolder = [TssFolder]::new()
        foreach ($fProp in $folderProperties) {
            if ($fProp -eq 'ChildFolders') {
                $outFolder.ChildFolders = $childFolders
            }
            if ($fProp -eq 'SecretTemplates') {
                $outFolder.SecretTemplates = $secretTemplates
            }
            $outFolder.$fProp = $f.$fProp
        }
    }
    return $outFolder
}