using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Secrets
{
    public class FieldListItem
    {
        public string Category { get; set; }
        public string Value { get; set; }
    }
}
