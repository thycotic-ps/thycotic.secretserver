using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class ConfigurationLoginPolicy
    {
        public bool EnableLoginPolicy { get; set; }
        public bool ForceLoginPolicy { get; set; }
        public string LoginPolicy { get; set; }
    }
}
