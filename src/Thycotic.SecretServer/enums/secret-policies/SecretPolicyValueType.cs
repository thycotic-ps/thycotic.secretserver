using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Enums
{
    public enum SecretPolicyValueType
    {
        Bool,
        Int,
        SecretId,
        Group,
        Schedule,
        SshMenuGroup,
        SshBlocklist
    }
}