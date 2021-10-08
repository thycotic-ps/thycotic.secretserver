param(
    [Parameter(Position = 0)]
    [PSCustomObject]$Object
)

<# determine .NET Version #>
$dotnetversionNum = $Object.Where({ $_.Name -eq 'DotNetVersion' }).Value
$dotnetversionString = switch ($dotnetversionNum) {
    378389 { '.Net Framework 4.5' }
    { $_ -in 378675,378758 } { '.Net Framework 4.5.1' }
    379893 { '.Net Framework 4.5.2' }
    { $_ -in 393295,393297 } { '.Net Framework 4.6' }
    { $_ -in 394254,394271 } { '.Net Framework 4.6.1' }
    { $_ -in 394802,394806 } { '.Net Framework 4.6.2' }
    { $_ -in 460798,460805 } { '.Net Framework 4.7' }
    { $_ -in 461308,461310 } { '.Net Framework 4.7.1' }
    { $_ -in 461808,461814 } { '.Net Framework 4.7.2' }
    { $_ -in 528040,528372,528049 } { '.Net Framework 4.8' }
    default { 'Unknown' }
}

[Thycotic.PowerShell.DistributedEngines.ServerCapabilities]@{
    DotNetRelease                   = $Object.Where({ $_.Name -eq 'DotNetVersion' }).value
    DotNetVersion                   = $dotnetversionString
    OperatingSystemVersion          = $Object.Where({ $_.Name -eq 'OperatingSystemVersion' }).value
    OperatingSystemPlatform         = $Object.Where({ $_.Name -eq 'OperationSystemPlatform' }).value
    OperatingSystemServicePack      = $Object.Where({ $_.Name -eq 'OperatingSystemServicePack' }).value
    Architecture                    = $Object.Where({ $_.Name -eq 'Architecture' }).value
    InstallationPath                = $Object.Where({ $_.Name -eq 'Directory' }).value
    ComputerName                    = $Object.Where({ $_.Name -eq 'ComputerName' }).value
    ProcessorCount                  = $Object.Where({ $_.Name -eq 'NumberOfProcessors' }).value
    PowerShellVersion               = $Object.Where({ $_.Name -eq 'PowerShell3Version' }).value
    SystemDirectory                 = $Object.Where({ $_.Name -eq 'SystemDirectory' }).value
    ServiceAccountName              = $Object.Where({ $_.Name -eq 'EngineServiceAccount_Name' }).value
    ServiceAccountCanRestartService = $Object.Where({ $_.Name -eq 'EngineServiceAccount_HasRightToStartService' }).value
    LastModifiedDate                = $Object[0].lastModifiedDate
}