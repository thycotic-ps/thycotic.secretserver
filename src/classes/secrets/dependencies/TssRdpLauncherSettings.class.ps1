class TssRdpLauncherSettings {
    [ValidateSet('No','Yes','UsePreferenceNo','UsePreferenceYes')]
    [string]
    $AllowClipboard

    [ValidateSet('No','Yes','UsePreferenceNo','UsePreferenceYes')]
    [string]
    $AllowDrives

    [ValidateSet('No','Yes','UsePreferenceNo','UsePreferenceYes')]
    [string]
    $AllowPrinters

    [ValidateSet('No','Yes','UsePreferenceNo','UsePreferenceYes')]
    [string]
    $AllowSmartCards

    [ValidateSet('No','Yes','UsePreferenceNo','UsePreferenceYes')]
    [string]
    $ConnectToConsole

    [int]
    $LauncherHeight

    [int]
    $LauncherWidth

    [ValidateSet('No','Yes','UsePreferenceNo','UsePreferenceYes')]
    [string]
    $UseCustomLauncherResolution
}