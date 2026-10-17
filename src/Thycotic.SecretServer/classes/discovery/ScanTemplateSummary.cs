using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class ScanTemplateSummary
    {
        public bool CanEdit { get; set; }
        public bool IsActive { get; set; }
        public int ScanTemplateId { get; set; }
        public string ScanTemplateName { get; set; }
        public int ScanTypeId { get; set; }
        public string ScanTypeName { get; set; }
    }
}
