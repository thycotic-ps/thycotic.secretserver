<#
.Synopsis
    Creates a TssUserLookup object
.Description
    Creates an instance of the TssUserLookup class
    Parsing the string value into the associated properties
        <Username> - <email>
#>
param(
    [pscustomobject]$FindRecord
)
begin {
}
process {
    $outObject = @()
    foreach ($f in $FindRecord) {
        $outLookup = [TssUserLookup]::new()
        $outLookup.Id = $f.Id

        $itemParse = $f.value.Split('-').Trim()
        $outLookup.Username = $itemParse[0]
        if ($itemParse[1]) {
            $outLookup.Email = $itemParse[1]
        }

        $outObject += $outLookup
    }
    return $outObject
}