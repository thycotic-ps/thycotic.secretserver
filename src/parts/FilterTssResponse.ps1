[cmdletbinding()]
param(
    [Parameter(Mandatory, Position = 0)]
    $Response,
    [Parameter(Mandatory, Position = 1)]
    [type]$TargetType
)

if ($null -eq $Response) { return }

$typeProps = $TargetType.GetProperties().Name
$sample = if ($Response -is [array]) { $Response[0] } else { $Response }

if ($null -ne $sample) {
    $extraProps = $sample.PSObject.Properties.Name | Where-Object { $_ -notin $typeProps }
    if ($extraProps) {
        Write-Verbose "[$($TargetType.FullName)] New Properties detected - $($extraProps -join ', ')"
    }
}

$Response | Select-Object -Property $typeProps
