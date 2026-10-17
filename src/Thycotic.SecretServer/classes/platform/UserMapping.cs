using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Platform
{
    public class UserMapping
    {
        public string PlatformUserId { get; set; }
        public string PlatformUserName { get; set; }
        public int? SecretServerUserId { get; set; }
        public string SecretServerUserName { get; set; }
    }
}
