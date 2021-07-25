using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class ProtocolHandlerSettings
    {
        public string ProtocolHandlerInstallTimeAllowedDomains { get; set; }
        public bool ProtocolHandlerInstallTimeDisableAutoUpdate { get; set; }
        public bool ProtocolHandlerInstallTimeSettingsEnabled { get; set; }
    }
}