using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.ExternalVaults
{
    public class SecretPermissionHistory
    {
        public int AuditId { get; set; }
        public DateTime? CreatedOn { get; set; }
        public int CreateUserId { get; set; }
        public string DisplayName { get; set; }
        public string ExternalVaultPermissionTypeId { get; set; }
        public int ExternalVaultSecretId { get; set; }
        public int GroupId { get; set; }
        public DateTime? HistoryDate { get; set; }
        public int HistoryUserId { get; set; }
        public bool WasRemoved { get; set; }
    }
}
