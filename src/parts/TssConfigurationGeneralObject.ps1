<#
    .Synopsis
        Creates a TssConfigurationGeneral object
#>
param(
    [pscustomobject]$Object
)

begin {
    $Properties = $Object.PSObject.Properties.Name
    if ($Object.applicationSettings) {
        $appSettingProperties = $Object.applicationSettings[0].PSObject.Properties.Name
    } else {
        Write-Verbose "No applicationSettings found on records object"
    }
}
process {
    if ($appSettingProperties) {
        $applicationSettings = [TssConfigurationApplicationSettings]::new()
        foreach ($cProp in $appSettingProperties) {
            if ($cProp -in $applicationSettings.PSObject.Properties.Name) {
                $applicationSettings.$cProp = $Object.applicationSettings.$cProp
            } else {
                Write-Warning "Property $cProp does not exist in the applicationSettings class. Please create a bug report at https://github.com/thycotic-ps/thycotic.secretserver/issues/new/choose"
            }
        }
    }

    $outObject = @()
    foreach ($p in $Object) {
        $currentObject = [TssConfigurationGeneral]::new()
        foreach ($pProp in $Properties) {
            if ($pProp -eq 'applicationSettings') {
                $currentObject.applicationSettings = $applicationSettings
            }
            if ($pProp -in $currentObject.PSObject.Properties.Name) {
                $currentObject.$pProp = $p.$pProp
            } else {
                Write-Warning "Property $pProp does not exist in the TssConfigurationGeneral class. Please create a bug report at https://github.com/thycotic-ps/thycotic.secretserver/issues/new/choose"
            }
        }
        $outObject += $currentObject
    }
    return $outObject
}