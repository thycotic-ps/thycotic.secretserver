using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Proxy
{
    public class SshClientOverride
    {
        public int ClientOverrideId { get; set; }
        public string[] Conflicts { get; set; }
        public string IpAddressRange { get; set; }
        public string TerminalClientType { get; set; }
    }
}
