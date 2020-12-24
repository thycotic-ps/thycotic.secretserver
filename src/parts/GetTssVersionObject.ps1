<#
.Synopsis
    Creates a TssVersion object and outputs
.Description
    Creates an instance of the TssVersion class to output based on the calling command
#>
param(
    [pscustomobject]$VersionRecord
)

begin {
    $source = $PSCmdlet.MyInvocation.MyCommand

    switch ($source) {
        'Get-TssVersion' {
            $versionProperties = $VersionRecord.model.PSObject.Properties.Name
            $VersionRecord = $VersionRecord.model
            $returnProps = 'Version'
        }
    }
}

process {
    foreach ($v in $VersionRecord) {
        $outVersion = [TssVersion]::new()
        foreach ($vProp in $versionProperties) {
            $outVersion.$vProp = $v.$vProp
        }
    }
    Select-Object -InputObject $outVersion -Property $returnProps
}