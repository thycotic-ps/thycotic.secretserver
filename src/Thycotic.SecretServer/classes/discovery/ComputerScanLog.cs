using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class ComputerScanLog
    {
        public int ComputerId { get; set; }
        public string ComputerName { get; set; }
        public int ComputerScanLogId { get; set; }
        public int? DiscoveryItemScannerId { get; set; }
        public string DiscoveryItemScannerName { get; set; }
        public int DiscoverySourceId { get; set; }
        public string DiscoverySourceName { get; set; }
        public DateTime? ScanDate { get; set; }
        public int? ScanItemTemplateId { get; set; }
        public string ScanItemTemplateName { get; set; }
        public string Status { get; set; }
        public bool Success { get; set; }
    }
}
