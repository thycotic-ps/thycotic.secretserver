<#
    .Synopsis
        Creates a TssReportCategory class in the Thycotic.SecretServer module.
    .Description
        Creates an instance of the TssReportCategory class to output the ReportCategory object
#>
param(
    [pscustomobject]$Object,
    [switch]$All
)

begin {
    $Properties = $Object[0].PSObject.Properties.Name
}

process {
    $outObject = @()
    foreach ($s in $Object) {
        $outCat = [TssReportCategory]::new()
        if ($PSBoundParameters['All']) {
            foreach ($sProp in $Properties) {
                switch ($sProp) {
                    'Id' { $outCat.ReportCategoryId = $s.$sProp }
                    'Name' { $outCat.ReportCategoryName = $s.$sProp }
                    'Description' { $outCat.ReportCategoryDescription = $s.$sProp }
                }
            }
        } else {
            foreach ($sProp in $Properties) {
                if ($sProp -in $outCat.PSObject.Properties.Name) {
                    $outCat.$sProp = $s.$sProp
                } else {
                    Write-Warning "Property $sProp does not exist in the TssReportCategory class. Please create a bug report at https://github.com/thycotic-ps/thycotic.secretserver/issues/new/choose"
                }
            }
        }
        $outObject += $outCat
    }
    return $outObject
}