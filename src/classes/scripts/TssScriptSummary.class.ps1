class TssScriptSummary {
    [boolean]
    $Active

    [string]
    $ConcurrencyId

    [string]
    $Description

    [string]
    $Name

    [int]
    $ScriptCategoryId

    [string]
    $ScriptCategoryName

    [int]
    $ScriptId

    [ValidateSet('PowerShell','SQL','SSH')]
    [string]
    $ScriptType
}