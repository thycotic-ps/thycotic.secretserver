using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Platform
{
    public class SyncStatus
    {
        public DateTime? EndDateTime { get; set; }
        public int ErrorCount { get; set; }
        public string LastLogEntry { get; set; }
        public int LastSyncGroupsCreated { get; set; }
        public int LastSyncUsersAddedToGroups { get; set; }
        public int LastSyncUsersRemovedFromGroups { get; set; }
        public DateTime? NextSynchronizationDateTime { get; set; }
        public DateTime? StartDateTime { get; set; }
    }
}
