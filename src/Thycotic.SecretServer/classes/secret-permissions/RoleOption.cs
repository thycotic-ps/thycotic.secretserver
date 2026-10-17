using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretPermissions
{
    public class RoleOption
    {
        public int Id { get; set; }
        public bool IsDefault { get; set; }
        public string Name { get; set; }
    }
}
