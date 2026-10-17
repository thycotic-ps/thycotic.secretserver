using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DevOpsSecretsVault
{
    public class DsvTenantItem
    {
        public bool Active { get; set; }
        public DateTime? DateAdded { get; set; }
        public int DsvTenantId { get; set; }
        public DateTime? LastSynced { get; set; }
        public string SecretName { get; set; }
        public int SyncInterval { get; set; }
        public string TenantName { get; set; }
    }
}
