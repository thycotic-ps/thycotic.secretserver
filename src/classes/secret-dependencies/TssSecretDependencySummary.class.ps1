class TssSecretDependencySummary {
    [boolean]
    $Enabled

    [int]
    $GroupId

    [int]
    $Id

    [string]
    $MachineName

    [int]
    $Order

    [ValidateSet('Success','Failed','NotRun')]
    [string]
    $RunResult

    [int]
    $SecretId

    [string]
    $ServiceName

    [int]
    $TypeId

    [string]
    $TypeName
}