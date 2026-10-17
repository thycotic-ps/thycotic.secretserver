using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Reports
{
    public class PermissionOption
    {
        public int RolePermissionId { get; set; }
        public string RolePermissionName { get; set; }
    }
}
