using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class DatabaseConfiguration
    {
        public string ApplicationPoolIdentity { get; set; }
        public string AuthenticationType { get; set; }
        public int? ConnectionTimeout { get; set; }
        public string DatabaseConfigFilePath { get; set; }
        public string DatabaseName { get; set; }
        public bool EnableMultiSubnetFailover { get; set; }
        public bool EnableSslEncryption { get; set; }
        public string FailoverPartner { get; set; }
        public bool HasDiskWritePermissions { get; set; }
        public bool IsTmsInstalled { get; set; }
        public string ServerName { get; set; }
        public bool TrustServerCertificate { get; set; }
        public string UserName { get; set; }
    }
}
