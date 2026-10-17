using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DevOpsSecretsVault
{
    public class DsvSync
    {
        public bool Active { get; set; }
        public DateTime? DateAdded { get; set; }
        public string DevOpsSecretVaultPath { get; set; }
        public int DevOpsSyncMapId { get; set; }
        public DateTime? LastSyncTime { get; set; }
        public DateTime? NextSyncTime { get; set; }
        public int SecretId { get; set; }
        public string SecretName { get; set; }
        public string Status { get; set; }
        public int TenantId { get; set; }
    }
}
