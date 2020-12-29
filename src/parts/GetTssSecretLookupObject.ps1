<#
.Synopsis
    Creates a TssSecretLookup object to output the SecretLookup object
.Description
    Creates an instance of the TssSecretLookup class to output a revised SecretLookup object
    Parsing the string value into the associated properties
        <Folder ID> - <Secret Template ID> - <Secret Name>
#>
param(
    [pscustomobject]$FindRecord
)
begin {
}
process {
    $outObject = @()
    foreach ($f in $FindRecord) {
        $outLookup = [TssSecretLookup]::new()
        $outLookup.SecretId = $f.Id

        $itemParse = $f.value.Split('-').Trim()
        $outLookup.FolderId = $itemParse[0]
        $outLookup.SecretTemplateId = $itemParse[1]
        $outLookup.SecretName = $itemParse[2]

        $outObject += $outLookup
    }
    return $outObject
}