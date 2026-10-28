using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretTemplates
{
    public class LauncherType
    {
        public bool Active { get; set; }
        public string LauncherTypeDescription { get; set; }
        public int LauncherTypeId { get; set; }
        public string LauncherTypeName { get; set; }
    }
}
