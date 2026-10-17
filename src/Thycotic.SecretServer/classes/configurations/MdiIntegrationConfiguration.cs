using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class MdiIntegrationConfiguration
    {
        public PSObject Actions { get; set; }
        public string AuthorizeUrl { get; set; }
        public bool Enabled { get; set; }
        public int SynchronizationIntervalHours { get; set; }
        public DateTime? SyncLastCompleteDate { get; set; }
        public DateTime? SyncLastStartDate { get; set; }
        public string TenantId { get; set; }
    }
}
