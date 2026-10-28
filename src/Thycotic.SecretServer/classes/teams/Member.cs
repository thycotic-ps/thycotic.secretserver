using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Teams
{
    public class Member
    {
        public string GroupDisplayName { get; set; }
        public int GroupId { get; set; }
        public int TeamGroupMembershipId { get; set; }
        public int TeamId { get; set; }
        public string Type { get; set; }
    }
}
