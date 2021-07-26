using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Users
{
    public class UserRoleSummary
    {
        public GroupAssignedRole[] Groups { get; set; }
        public bool IsDirectAssignment { get; set; }
        public int RoleId { get; set; }
        public string RoleName { get; set; }
    }
}