using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class SourceScanner
    {
        public bool CanEdit { get; set; }
        public object[] Credentials { get; set; }
        public string DiscoveryItemScannerDescription { get; set; }
        public string DiscoveryItemScannerDisplayName { get; set; }
        public int DiscoveryItemScannerId { get; set; }
        public string DiscoveryItemScannerName { get; set; }
        public int DiscoveryScannerId { get; set; }
        public int DiscoverySourceId { get; set; }
        public string InputScanItemTemplateDisplayName { get; set; }
        public int InputScanItemTemplateId { get; set; }
        public string InputScanItemTemplateName { get; set; }
        public bool IsActive { get; set; }
        public string OutputScanItemTemplateDisplayName { get; set; }
        public int OutputScanItemTemplateId { get; set; }
        public string OutputScanItemTemplateName { get; set; }
        public object[] ScannerItems { get; set; }
        public int SortOrder { get; set; }
    }
}
