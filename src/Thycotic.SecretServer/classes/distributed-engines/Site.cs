using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using Thycotic.PowerShell.Enums;

namespace Thycotic.PowerShell.DistributedEngines
{
    public class Site
    {
        public bool Active { get; set; }
        public bool EnableCredSspForWinRm { get; set; }
        public bool EnableRdpProxy { get; set; }
        public bool EnableSshProxy { get; set; }
        public int HeartbeatInterval { get; set; }
        public int PowerShellSecretId { get; set; }
        public SiteProcessLocationType ProcessingLocation { get; set; }
        public int RdpProxyPort { get; set; }
        public bool RdpProxyPortInherited { get; set; }
        public int SecretCount { get; set; }
        public int SiteConnectorId { get; set; }
        public int SiteId { get; set; }
        public string SiteName { get; set; }
        public int SshProxyPort { get; set; }
        public bool SshProxyPortInherited { get; set; }
        public bool SystemSite { get; set; }
        public string WinRmEndPointUrl { get; set; }
    }
}