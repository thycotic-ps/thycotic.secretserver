<#
.Synopsis
    Creates a TssSecretLookup object to output the SecretLookup object
.Description
    Creates an instance of the TssSecretLookup class to output a revised SecretLookup object
    Parsing the string value into the associated properties
        <Folder ID> - <Secret Template ID> - <Secret Name>
#>
param(
    [pscustomobject]$FindRecord,
    [switch]$IsId
)
begin {
}
process {
    $outObject = @()
    if ($PSBoundParameters['IsId']) {
        $outObject = [TssSecretLookup]@{
            Id = $FindRecord.id
            SecretName = $FindRecord.value
        }
    } else {
        foreach ($f in $FindRecord) {
            $outLookup = [TssSecretLookup]::new()
            $outLookup.Id = $f.Id

            $itemParse = $f.value.Split('-').Trim()
            $outLookup.FolderId = $itemParse[0]
            $outLookup.SecretTemplateId = $itemParse[1]
            $outLookup.SecretName = $itemParse[2]

            $outObject += $outLookup
        }
    }
    return $outObject
}