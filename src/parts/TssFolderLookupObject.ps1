<#
.Synopsis
    Creates a TssFolderLookup object to output the SecretLookup object
.Description
    Creates an instance of the TssFolderLookup class to output a revised SecretLookup object
    Parsing the string value into the associated properties
        <ID> - <FolderName>
#>
param(
    [pscustomobject]$FindRecord
)
begin {
}
process {
    $outObject = @()
    foreach ($f in $FindRecord) {
        $outLookup = [TssFolderLookup]::new()
        $outLookup.Id = $f.Id
        $outLookup.FolderName = $f.Value

        $outObject += $outLookup
    }
    return $outObject
}