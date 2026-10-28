using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class SystemLogConfiguration
    {
        public bool AllowViewingOnline { get; set; }
        public bool EnableSystemLog { get; set; }
        public int? MaxLogLength { get; set; }
        public bool NotifyWhenShrunk { get; set; }
    }
}
