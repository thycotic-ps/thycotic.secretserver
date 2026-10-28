using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.ExternalVaults
{
    public class Secret
    {
        public bool Active { get; set; }
        public bool EnableInheritPermissions { get; set; }
        public string ExternalVaultDisplayName { get; set; }
        public int ExternalVaultId { get; set; }
        public string ExternalVaultName { get; set; }
        public int ExternalVaultSecretId { get; set; }
        public string ExternalVaultType { get; set; }
        public DateTime? LastPushDate { get; set; }
        public string LastPushStatus { get; set; }
        public string LastPushStatusDescription { get; set; }
        public int? LinkedSecretId { get; set; }
        public string LinkedSecretName { get; set; }
        public object[] LinkedVaults { get; set; }
        public string MappingModeId { get; set; }
        public object[] Mappings { get; set; }
        public string Name { get; set; }
        public PSObject Permissions { get; set; }
        public string Transform { get; set; }
        public PSObject VaultPermissions { get; set; }
        public string VersionId { get; set; }
    }
}
