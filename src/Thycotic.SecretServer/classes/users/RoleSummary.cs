using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Users
{
    public class RoleSummary
    {
        public string Name { get; set; }
        public int RoleId { get; set; }
    }
}