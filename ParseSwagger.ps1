#Requires -Modules ImportExcel
$ss9 = get-content C:\temp\swagger\swagger_token_10.9.json | ConvertFrom-Json
$ss932 = get-content C:\temp\swagger\swagger_token_10.9.32.json | ConvertFrom-Json
$ss8 = get-content C:\temp\swagger\swagger_token_10.8.4.json | ConvertFrom-Json
$ss7 = get-content C:\temp\swagger\swagger_token_10.7.59.json | ConvertFrom-Json

$ss9Data = @()
foreach ($def in $ss9.definitions) {
    $defProps = $def.PSObject.Properties.Name | Sort-Object
    foreach ($d in $defProps) {
        $primName = $d
        $description = $def.$d.description

        $props = $def.$d.properties
        $propsProps = $props.PSObject.Properties.Name | Sort-Object
        foreach ($p in $propsProps) {
            $ss9Data += $props.$p | Select-Object @{L='ModelName';E={$primName}}, @{L='ModelDescription';E={$description}}, @{L='PropertyDescription';E={$_.description}}, @{L='PropertyType';E={$_.type}}
        }
    }
}
$ss9Data | Export-Excel -Path SwaggerDetails.xlsx -WorkSheetname 'SecretServer 10.9' -Append -BoldTopRow -FreezeTopRow -AutoNameRange

$ss932Data = @()
foreach ($def in $ss932.definitions) {
    $defProps = $def.PSObject.Properties.Name | Sort-Object
    foreach ($d in $defProps) {
        $primName = $d
        $description = $def.$d.description

        $props = $def.$d.properties
        $propsProps = $props.PSObject.Properties.Name | Sort-Object
        foreach ($p in $propsProps) {
            $ss932Data += $props.$p | Select-Object @{L='ModelName';E={$primName}}, @{L='ModelDescription';E={$description}}, @{L='PropertyDescription';E={$_.description}}, @{L='PropertyType';E={$_.type}}
        }
    }
}
$ss932Data | Export-Excel -Path SwaggerDetails.xlsx -WorkSheetname 'SecretServer 10.9.32' -Append -BoldTopRow -FreezeTopRow -AutoNameRange

$ss8Data = @()
foreach ($def in $ss8.definitions) {
    $defProps = $def.PSObject.Properties.Name | Sort-Object
    foreach ($d in $defProps) {
        $primName = $d
        $description = $def.$d.description

        $props = $def.$d.properties
        $propsProps = $props.PSObject.Properties.Name | Sort-Object
        foreach ($p in $propsProps) {
            $ss8Data += $props.$p | Select-Object @{L='ModelName';E={$primName}}, @{L='ModelDescription';E={$description}}, @{L='PropertyDescription';E={$_.description}}, @{L='PropertyType';E={$_.type}}
        }
    }
}
$ss8Data | Export-Excel -Path SwaggerDetails.xlsx -WorkSheetname 'SecretServer 10.8.4' -Append -BoldTopRow -FreezeTopRow -AutoNameRange

$ss7Data = @()
foreach ($def in $ss7.definitions) {
    $defProps = $def.PSObject.Properties.Name | Sort-Object
    foreach ($d in $defProps) {
        $primName = $d
        $description = $def.$d.description

        $props = $def.$d.properties
        $propsProps = $props.PSObject.Properties.Name | Sort-Object
        foreach ($p in $propsProps) {
            $ss7Data += $props.$p | Select-Object @{L='ModelName';E={$primName}}, @{L='ModelDescription';E={$description}}, @{L='PropertyDescription';E={$_.description}}, @{L='PropertyType';E={$_.type}}
        }
    }
}
$ss7Data | Export-Excel -Path SwaggerDetails.xlsx -WorkSheetname 'SecretServer 10.7.59' -Append -BoldTopRow -FreezeTopRow -AutoNameRange