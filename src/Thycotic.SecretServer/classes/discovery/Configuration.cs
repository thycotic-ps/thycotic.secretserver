using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class Configuration
    {
        public int DiscoveryIntervalDays { get; set; }
        public int DiscoveryIntervalHours { get; set; }
        public int DiscoveryScanOffsetHours { get; set; }
        public bool EnableDiscovery { get; set; }
        public int EngineADDiscoveryBatchSize { get; set; }
        public bool IgnoreClusterNodeObjects { get; set; }
        public int MaxLogAgeDays { get; set; }
    }
}
