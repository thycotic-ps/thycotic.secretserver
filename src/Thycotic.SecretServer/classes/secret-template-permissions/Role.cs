using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretTemplatePermissions
{
    public class Role
    {
        public int RoleId { get; set; }
        public string RoleName { get; set; }
    }
}
