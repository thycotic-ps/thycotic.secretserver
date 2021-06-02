class TssSecretHeartbeatStatus {
    [ValidateSet('Failed','Success','Pending','Disabled','UnableToConnect','UnknownError','IncompatibleHost','AccountLockedOut','DnsMismatch','UnableToValidateServerPublicKey','Processing')]
    [string]
    $Status

    [Nullable[datetime]]
    $LastHeartbeatCheck
}