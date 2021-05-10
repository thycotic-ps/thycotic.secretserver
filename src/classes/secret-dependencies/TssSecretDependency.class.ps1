class TssSecretDependency {
    [boolean]
    $Active

    [boolean]
    $ChildDependencyStatus

    [int]
    $ConditionDependencyId

    [string]
    $ConditionMode

    [TssSecretDependencyTemplate]
    $DependencyTemplate

    [string]
    $Description

    [int]
    $GroupId

    [int]
    $Id

    [string]
    $LogMessage

    [int]
    $PrivilegedAccountSecretId

    [TssSecretDependencyRunScript]
    $RunScript

    [boolean]
    $SecretDependencyStatus

    [int]
    $SecretId

    [string]
    $SecretName

    [pscustomobject[]]
    $Settings

    [int]
    $SortOrder

    [int]
    $SshKeySecretId

    [string]
    $SshKeySecretName

    [int]
    $TypeId

    [string]
    $TypeName
}