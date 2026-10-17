using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Platform
{
    public class TenantStatus
    {
        public string Hostname { get; set; }
        public bool TenantExists { get; set; }
        public string TenantId { get; set; }
    }
}
