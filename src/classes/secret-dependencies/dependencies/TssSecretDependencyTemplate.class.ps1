class TssSecretDependencyTemplate {
    [int]
    $ChangerScriptId

    [TssSecretDependencyScanItemFields[]]
    $DependencyScanItemFields

    [string]
    $ScriptName

    [int]
    $SecretDependencyChangerId

    [int]
    $SecretDependencyTemplateId
}