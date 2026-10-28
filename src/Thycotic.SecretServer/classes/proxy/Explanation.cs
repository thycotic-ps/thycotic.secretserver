using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Proxy
{
    public class Explanation
    {
        public string RdpProxyExplanation { get; set; }
        public PSObject SshProxyExplanation { get; set; }
        public string SshTerminalBlockListExplanation { get; set; }
        public string SshTerminalBlockListOverrideExplanation { get; set; }
        public string SshTerminalExplanation { get; set; }
    }
}
