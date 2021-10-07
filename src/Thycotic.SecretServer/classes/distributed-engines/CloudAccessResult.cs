using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DistributedEngines
{
    public class CloudAccessResult
    {
        public string ItemName { get; set; }
        public string HostAddress { get; set; }
        public int Port { get; set; }
        public string Status { get; set; }
    }
}