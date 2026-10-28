using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class SourceAvailableScanner
    {
        public string DiscoveryItemScannerDescription { get; set; }
        public int DiscoveryItemScannerId { get; set; }
        public string DiscoveryItemScannerName { get; set; }
        public int DiscoveryScanTypeId { get; set; }
        public bool IsSuggested { get; set; }
    }
}
