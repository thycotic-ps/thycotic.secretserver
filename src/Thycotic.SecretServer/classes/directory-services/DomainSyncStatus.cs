using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DirectoryServices
{
    public class DomainSyncStatus
    {
        public int DisabledUsers { get; set; }
        public int DomainId { get; set; }
        public int DomainUsersUpdatedSinceLastSynchronization { get; set; }
        public int NewUsersCreated { get; set; }
        public int NewUsersCreatedAsDisabled { get; set; }
        public int UsersRemovedFromGroups { get; set; }
        public int UsersWithGroupMembershipChanges { get; set; }
    }
}