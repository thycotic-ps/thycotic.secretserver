using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.ExternalVaults
{
    public class ExternalVault
    {
        public bool Active { get; set; }
        public int ConnectedVaultCount { get; set; }
        public int CredentialSecretId { get; set; }
        public string CredentialSecretName { get; set; }
        public string DisplayName { get; set; }
        public int ExternalVaultId { get; set; }
        public string ExternalVaultType { get; set; }
        public PSObject HashiCorpConnectionParameters { get; set; }
        public DateTime? LastPullDate { get; set; }
        public string Name { get; set; }
        public PSObject Permissions { get; set; }
        public string SecretRegex { get; set; }
        public int? SiteId { get; set; }
        public string SiteName { get; set; }
    }
}
