using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Rpc
{
    public class PasswordTypeField
    {
        public string Name { get; set; }
        public int PasswordTypeFieldId { get; set; }
        public int ScanItemFieldId { get; set; }
    }
}