using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Proxy
{
    public class RdpConfiguration
    {
        public bool? AllowSiteSelectionForActiveDirectoryAccounts { get; set; }
        public int? DaysToKeepOperationalLogs { get; set; }
        public bool? EnableRdpGateway { get; set; }
        public bool? EnableRdpProxy { get; set; }
        public bool? EnableRemoteHostValidation { get; set; }
        public bool IsCloud { get; set; }
        public bool? ProxyNewSecretsByDefault { get; set; }
        public int? RdpGatewayPort { get; set; }
        public int? RdpProxyPort { get; set; }
        public PSObject RdpServerCertificate { get; set; }
        public string SspiAuthenticationMethod { get; set; }
    }
}
