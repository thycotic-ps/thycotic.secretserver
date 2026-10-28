using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.ExternalVaults
{
    public class SecretItem
    {
        public bool Active { get; set; }
        public string ExternalVaultDisplayName { get; set; }
        public int ExternalVaultId { get; set; }
        public string ExternalVaultName { get; set; }
        public int ExternalVaultSecretId { get; set; }
        public string ExternalVaultType { get; set; }
        public DateTime? LastPushDate { get; set; }
        public string LastPushStatus { get; set; }
        public int? LinkedSecretId { get; set; }
        public string LinkedSecretName { get; set; }
        public string MappingModeId { get; set; }
        public string Name { get; set; }
        public PSObject Permissions { get; set; }
    }
}
