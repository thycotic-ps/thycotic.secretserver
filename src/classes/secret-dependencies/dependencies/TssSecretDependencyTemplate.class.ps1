class TssSecretDependencyScanItemFields {
    [int]
    $Id

    [string]
    $Name

    [string]
    $ParentName

    [string]
    $Value
}

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