using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DistributedEngines
{
    public class SiteConnectorSummary
    {
        public bool Active { get; set; }
        public string Hostname { get; set; }
        public string QueueType { get; set; }
        public int SiteConnectorId { get; set; }
        public string SiteConnectorName { get; set; }
        public bool Validated { get; set; }
        public string Version { get; set; }
    }
}