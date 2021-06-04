class TssSecretHookParameter {
    [string]
    $ParameterName

    [string]
    $ParameterValue

    [string]
    $ParameterType = 'Literal'
}
class TssSecretHook {
    [int]
    $SecretHookId

    [int]
    $HookId

    [string]
    $Name

    [string]
    $Description

    [int]
    $SortOrder

    [string]
    $PrePostOption

    [int]
    $EventActionId

    [int]
    $ScriptTypeId

    [int]
    $ScriptId

    [boolean]
    $Status

    [boolean]
    $StopOnFailure

    [string]
    $ServerName

    [string]
    $ServerKeyDigest

    [int]
    $Port

    [string]
    $Database

    [string]
    $Arguments

    [int]
    $SshKeySecretId

    [int]
    $PrivilegeSecretId

    [TssSecretHookParameter[]]
    $Parameters

    [string]
    $FailureMessage

    [void]
    SetHookParameter([string]$Name, [string]$Value) {
        foreach ($i in $this.Parameters) {
            if ($i.ParameterName -eq $Name) {
                $i.ParameterValue = $Value
            }
        }
    }
}