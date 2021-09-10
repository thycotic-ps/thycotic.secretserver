using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Enums
{
    public enum MfaProviderType
    {
        None,
        Radius,
        TOTPAuthenticator,
        Duo,
        Fido2,
        Email
    }
}