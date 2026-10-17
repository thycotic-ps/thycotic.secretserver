using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class StatusScanResult
    {
        public int DiscoverySourceId { get; set; }
        public string DiscoverySourceName { get; set; }
        public int ErrorCount { get; set; }
        public int SuccessCount { get; set; }
    }
}
