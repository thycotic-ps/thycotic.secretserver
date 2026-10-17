using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class CommandSetSummary
    {
        public int DiscoveryCommandSetId { get; set; }
        public string DiscoveryCommandSetName { get; set; }
        public int DiscoveryScannerId { get; set; }
        public string DiscoveryScannerTypeName { get; set; }
        public int DiscoveryScanTypeId { get; set; }
        public string DiscoveryScanTypeName { get; set; }
        public bool IsActive { get; set; }
        public bool IsStandard { get; set; }
    }
}
