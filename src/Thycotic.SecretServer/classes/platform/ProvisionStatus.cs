using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Platform
{
    public class ProvisionStatus
    {
        public string OneTimePlatformLoginURL { get; set; }
        public bool OpenIdConnectEnabled { get; set; }
        public DateTime? RequestStartDateTime { get; set; }
    }
}
