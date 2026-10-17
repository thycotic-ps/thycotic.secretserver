using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Proxy
{
    public class SshClient
    {
        public int ClientId { get; set; }
        public string IpAddress { get; set; }
        public DateTime? LastConnectionDate { get; set; }
        public string TerminalClientType { get; set; }
    }
}
