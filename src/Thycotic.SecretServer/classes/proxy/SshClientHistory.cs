using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Proxy
{
    public class SshClientHistory
    {
        public string AuthenticateResult { get; set; }
        public DateTime? CreatedDate { get; set; }
        public string EngineIdentityGuid { get; set; }
        public string IpAddress { get; set; }
    }
}
