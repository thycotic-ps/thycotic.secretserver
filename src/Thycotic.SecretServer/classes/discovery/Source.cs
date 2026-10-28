using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class Source
    {
        public bool Active { get; set; }
        public int DaysToKeepMachines { get; set; }
        public bool DiscoverSpecificOUs { get; set; }
        public string DiscoveryScannerId { get; set; }
        public int DiscoverySourceId { get; set; }
        public PSObject DiscoverySourceSettings { get; set; }
        public DateTime? LastDiscoveryRunDate { get; set; }
        public string MachineNameResolutionType { get; set; }
        public string Name { get; set; }
        public int? SecretId { get; set; }
        public int SiteId { get; set; }
    }
}
