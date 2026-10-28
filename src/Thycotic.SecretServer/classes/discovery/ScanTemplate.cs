using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class ScanTemplate
    {
        public int? AccountScanId { get; set; }
        public int[] AccountScanIds { get; set; }
        public PSObject Actions { get; set; }
        public string ConcurrencyId { get; set; }
        public bool HasBeenUsed { get; set; }
        public bool IsActive { get; set; }
        public bool IsInUse { get; set; }
        public string ParentConcurrencyId { get; set; }
        public int? ParentScanTemplateId { get; set; }
        public string ParentScanTemplateName { get; set; }
        public object[] ScanTemplateFields { get; set; }
        public int ScanTemplateId { get; set; }
        public string ScanTemplateName { get; set; }
        public int ScanTypeId { get; set; }
        public string ScanTypeName { get; set; }
    }
}
