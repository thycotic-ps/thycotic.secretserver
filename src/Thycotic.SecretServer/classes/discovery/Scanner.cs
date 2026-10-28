using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class Scanner
    {
        public PSObject Actions { get; set; }
        public int BaseScannerId { get; set; }
        public string BaseScannerName { get; set; }
        public int? CommandSetId { get; set; }
        public string CommandSetName { get; set; }
        public string ConcurrencyId { get; set; }
        public string DependencyItemScannerDisplayName { get; set; }
        public string DiscoveryItemScannerDisplayDescription { get; set; }
        public string DiscoveryItemScannerDisplayName { get; set; }
        public int InputScanItemTemplateId { get; set; }
        public string InputTemplateDisplayName { get; set; }
        public string InputTemplateName { get; set; }
        public bool IsActive { get; set; }
        public bool IsInUse { get; set; }
        public string ItemScannerDescription { get; set; }
        public int ItemScannerId { get; set; }
        public string ItemScannerName { get; set; }
        public int OutputScanItemTemplateId { get; set; }
        public string OutputTemplateDisplayName { get; set; }
        public string OutputTemplateName { get; set; }
        public int ScannerId { get; set; }
        public object[] ScannerItems { get; set; }
        public int ScanTypeId { get; set; }
        public string ScriptArguments { get; set; }
        public int? ScriptId { get; set; }
        public string ScriptName { get; set; }
    }
}
