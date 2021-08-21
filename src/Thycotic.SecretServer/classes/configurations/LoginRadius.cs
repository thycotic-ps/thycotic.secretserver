using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class LoginRadius
    {
        public bool AttemptUserPassword { get; set; }
        public string ClientPortRange { get; set; }
        public string DefaultUsername { get; set; }
        public bool DisableNasIpAddressAttribute { get; set; }
        public bool Enable { get; set; }
        public bool EnableFailoverServer { get; set; }
        public bool EnableRadiusNasId { get; set; }
        public string FailoverServerIP { get; set; }
        public int FailoverServerPort { get; set; }
        public string FailoverSharedSecret { get; set; }
        public int FailoverTimeoutSeconds { get; set; }
        public string LoginExplanation { get; set; }
        public string NasId { get; set; }
        public int Protocol { get; set; }
        public string ServerIP { get; set; }
        public int ServerPort { get; set; }
        public string SharedSecret { get; set; }
        public bool SharedSecretSameForAllUsers { get; set; }
        public int TimeoutSeconds { get; set; }
    }
}