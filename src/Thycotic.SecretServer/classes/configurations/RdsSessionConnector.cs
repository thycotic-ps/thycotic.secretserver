using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class RdsSessionConnector
    {
        public bool? AllowConnectionSharing { get; set; }
        public int? CertificateSecretId { get; set; }
        public bool Enabled { get; set; }
        public int? SessionTimeoutInSeconds { get; set; }
    }
}
