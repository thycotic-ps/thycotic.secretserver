using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Rpc
{
    public class ScanTemplateField
    {
        public bool IsRequired { get; set; }
        public int ScanItemFieldId { get; set; }
        public string ScanItemFieldName { get; set; }
    }
}
