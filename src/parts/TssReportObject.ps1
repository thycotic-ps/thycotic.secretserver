<#
    .Synopsis
        Creates a TssReport class in the Thycotic.SecretServer module.
    .Description
        Creates an instance of the TssReport class to output the ReportModel object
#>
param(
    [pscustomobject]$Object
)

begin {
    $Properties = $Object.PSObject.Properties.Name
}

process {
        foreach ($r in $Object) {
            $outObject = [TssReport]::new()
                foreach ($rProp in $Properties) {
                    if ($rProp -in $outObject.PSObject.Properties.Name) {
                        $outObject.$rProp = $r.$rProp
                    } else {
                        Write-Warning "Property $rProp does not exist in the TssReport class. Please create a bug report at https://github.com/thycotic-ps/thycotic.secretserver/issues/new/choose"
                    }
                }
        }
        return $outObject
}