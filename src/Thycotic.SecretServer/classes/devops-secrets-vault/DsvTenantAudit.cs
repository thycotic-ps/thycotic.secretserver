using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DevOpsSecretsVault
{
    public class DsvTenantAudit
    {
        public string Action { get; set; }
        public DateTime? Date { get; set; }
        public string Notes { get; set; }
        public string TenantName { get; set; }
        public string UserDisplayName { get; set; }
    }
}
