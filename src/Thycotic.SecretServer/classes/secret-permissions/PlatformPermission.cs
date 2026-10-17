using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretPermissions
{
    public class PlatformPermission
    {
        public bool HasRequestedAclRole { get; set; }
        public string Message { get; set; }
        public bool Success { get; set; }
    }
}
