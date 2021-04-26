class TssPasswordType {
    [boolean]
    $Active

    [boolean]
    $CanEdit

    [int]
    $CustomPort

    [string]
    $ExitCommand

    [TssPasswordTypeField[]]
    $Fields

    [boolean]
    $HasCommands

    [boolean]
    $HasLDAPSettings

    [string]
    $HeartbeatScriptArgs

    [int]
    $HeartbeatScriptId

    [boolean]
    $IgnoreSSL

    [boolean]
    $IsWeb

    [int]
    $LdapConnectionSettingsId

    [string]
    [ValidateSet('NewLine','CarriageReturn','CarriageReturnNewLine')]
    $LineEnding

    [string]
    $MainframeConnectionString

    [string]
    $Name

    [string]
    $OdbcConnectionString

    [int]
    $PasswordTypeId

    [string]
    $RpcScriptArgs

    [int]
    $RpcScriptId

    [string]
    $RunnerType

    [int]
    $ScanItemTemplateId

    [string]
    $TypeName

    [boolean]
    $UseSSL

    [boolean]
    $UseUsernameAndPassword

    [boolean]
    $ValidForTakeover

    [string]
    $WindowsCustomPorts
}