using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DirectoryServices
{
    public class SyncStatus
    {
        public DomainSyncStatus[] DomainStatus { get; set; }
        public DateTime? EndDateTime { get; set; }
        public int ErrorCount { get; set; }
        public int EstimatedPercentComplete { get; set; }
        public DateTime? NextSynchronizationDateTime { get; set; }
        public DateTime? StartDateTime { get; set; }
    }
}