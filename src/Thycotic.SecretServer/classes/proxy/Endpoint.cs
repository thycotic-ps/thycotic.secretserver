using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Proxy
{
    public class Endpoint
    {
        public int DefaultRdpGatewayPort { get; set; }
        public int DefaultRdpProxyPort { get; set; }
        public int DefaultSshProxyPort { get; set; }
        public object[] Engines { get; set; }
        public object[] Nodes { get; set; }
        public bool RdpGatewayEnabled { get; set; }
        public bool RdpProxyEnabled { get; set; }
        public object[] Sites { get; set; }
        public bool SshProxyEnabled { get; set; }
    }
}
