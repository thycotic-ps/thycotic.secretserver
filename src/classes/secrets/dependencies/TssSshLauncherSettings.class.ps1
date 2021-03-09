class TssSshLauncherSettings {
    [boolean]
    $CanConnectAsCredentials

    [ValidateSet('ConnectAsSecret','ConnectAsDifferentSecret','UseSshKeyOnSecret')]
    [string]
    $LauncherType

    [int]
    $SecretId

    [string]
    $SecretName

    [int]
    $SshKeyExtendedTypeId
}