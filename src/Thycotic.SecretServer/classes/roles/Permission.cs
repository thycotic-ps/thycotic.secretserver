using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Roles
{
    public class Permission
    {
        public string Name { get; set; }
        public int RolePermissionId { get; set; }
        public string RoleType { get; set; }
    }
}
