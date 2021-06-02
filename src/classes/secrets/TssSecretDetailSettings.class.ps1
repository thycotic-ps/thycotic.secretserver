class TssSecretDetailSettings {
    [Nullable[datetime]]
    $ExpirationDate

    [int]
    $ExpirationDayInterval

    [string]
    $ExpirationTemplateText

    [ValidateSet('Template','DayInterval','SpecificDate','Disabled')]
    [string]
    $ExpirationType

    [TssOneTimePasswordSettings]
    $OneTimePasswordSettings

    [TssRdpLauncherSettings]
    $RdpLauncherSettings

    [boolean]
    $SendEmailWhenChanged

    [boolean]
    $SendEmailWhenHeartbeatFails

    [boolean]
    $SendEmailWhenViewed

    [TssSshLauncherSettings]
    $SshLauncherSettings
}