class TssScriptAdditionalDataParams {
    [string]
    $Name

    [int]
    $SshType
}
class TssScriptAdditionalData {
    [int]
    $Port

    [int]
    $LineEnding

    [TssScriptAdditionalDataParams[]]
    $Params

    [boolean]
    $DoNotUseEnvironment

    [int]
    $Version
}
class TssScript {
    [boolean]
    $Active

    [TssScriptAdditionalData]
    $AdditionalData

    [string]
    $ConcurrencyId

    [string]
    $Description

    [string]
    $Name

    [string]
    $OdbcConnectionStringArgs

    [string[]]
    $Script

    [int]
    $ScriptCategoryId

    [string]
    $ScriptCategoryName

    [int]
    $ScriptId

    [ValidateSet('PowerShell','SQL','SSH')]
    [string]
    $ScriptType

    [int]
    $UsageCount

    [TssScriptAdditionalDataParams[]]
    GetScriptParams() {
        return $this.AdditionalData.Params
    }
}