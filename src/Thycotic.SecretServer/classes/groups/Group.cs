using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Groups
{
    public class Group
    {
        public string AdGuid { get; set; }
        public bool CanEditMembers { get; set; }
        public DateTime? Created { get; set; }
        public int DomainId { get; set; }
        public string DomainName { get; set; }
        public bool Enabled { get; set; }
        public bool HasGroupOwners { get; set; }
        public int Id { get; set; }
        public bool IsEditable { get; set; }
        public string Name { get; set; }
        public object[] OwnerGroups { get; set; }
        public GroupOwner[] Owners { get; set; }
        public object[] OwnerUsers { get; set; }
        public bool Synchronized { get; set; }
        public bool SynchronizeNow { get; set; }
        public bool SystemGroup { get; set; }
    }
}