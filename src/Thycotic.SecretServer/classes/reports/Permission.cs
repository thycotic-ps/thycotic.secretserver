using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Reports
{
    public class Permission
    {
        public PSObject Group { get; set; }
        public PSObject RolePermission { get; set; }
    }
}
