using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Users
{
    public class Team
    {
        public bool Active { get; set; }
        public int? DomainId { get; set; }
        public bool IsDirectlyAssigned { get; set; }
        public string TeamDescription { get; set; }
        public object[] TeamGroupMemberships { get; set; }
        public int TeamId { get; set; }
        public string TeamName { get; set; }
    }
}
