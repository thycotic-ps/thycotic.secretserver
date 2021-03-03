class TssSecretPasswordStatus {
    [string]
    [ValidateSet('None','Pending','Success','Fail')]
    $Status

    [datetime]
    $LastRpcDate

    [string]
    $RpcMessage

    [int]
    $FailedAttempts

    [datetime]
    $NextRpcDate
}