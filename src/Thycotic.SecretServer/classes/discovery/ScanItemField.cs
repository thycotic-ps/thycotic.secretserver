using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class ScanItemField
    {
        public string ScanItemFieldDisplayName { get; set; }
        public int ScanItemFieldId { get; set; }
        public string ScanItemFieldName { get; set; }
    }
}
