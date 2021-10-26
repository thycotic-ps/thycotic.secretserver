using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Enums
{
    public enum SecretHeartbeatStatus
    {
        Failed = 0,
        Success = 1,
        Pending = 2,
        Disabled = 3,
        UnableToConnect = 4,
        UnknownError = 5,
        IncompatibleHost = 6,
        AccountLockedOut = 7,
        DnsMismatch = 8,
        UnableToValidateServerPublicKey = 9,
        Processing = 10,
        ArgumentError = 11,
        AccessDenied = 12
    }
}