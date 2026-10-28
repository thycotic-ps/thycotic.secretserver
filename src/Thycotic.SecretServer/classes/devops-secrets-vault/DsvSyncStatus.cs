using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DevOpsSecretsVault
{
    public class DsvSyncStatus
    {
        public bool Active { get; set; }
        public DateTime? DateAdded { get; set; }
        public string DevOpsSecretVaultPath { get; set; }
        public int DevOpsSyncMapId { get; set; }
        public DateTime? LastSyncTime { get; set; }
        public string SecretName { get; set; }
        public string Status { get; set; }
    }
}
