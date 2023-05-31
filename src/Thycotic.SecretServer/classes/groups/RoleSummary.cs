using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Groups
{
    public class RoleSummary
    {
        public int RoleId { get; set; }
        public string Name { get; set; }
    }
}