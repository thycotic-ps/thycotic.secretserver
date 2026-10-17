using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DependencyChangers
{
    public class ScanField
    {
        public bool IncludeInMatch { get; set; }
        public bool IsActive { get; set; }
        public bool IsRequired { get; set; }
        public int? ParentScanItemFieldId { get; set; }
        public string ParentScanItemFieldName { get; set; }
        public int ScanItemFieldId { get; set; }
        public string ScanItemFieldName { get; set; }
        public int ScanItemTemplateId { get; set; }
        public int SortOrder { get; set; }
        public bool SystemField { get; set; }
    }
}
