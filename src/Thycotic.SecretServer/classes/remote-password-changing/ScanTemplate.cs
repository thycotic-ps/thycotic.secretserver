using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Rpc
{
    public class ScanTemplate
    {
        public ScanTemplateField[] Fields { get; set; }
        public int ScanItemTemplateId { get; set; }
        public string ScanItemTemplateName { get; set; }
    }
}
