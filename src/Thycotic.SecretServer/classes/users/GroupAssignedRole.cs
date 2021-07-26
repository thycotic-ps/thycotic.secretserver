using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Users
{
    public class GroupAssignedRole
    {
        public int GroupId { get; set; }
        public string GroupName { get; set; }
    }
}