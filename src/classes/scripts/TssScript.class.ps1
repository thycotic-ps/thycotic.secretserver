class TssScript {
    [boolean]
    $Active

    [string]
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
}