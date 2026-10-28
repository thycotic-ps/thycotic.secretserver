using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretTemplatePermissions
{
    public class Grouped
    {
        public object[] Assignments { get; set; }
        public int RoleId { get; set; }
        public string RoleName { get; set; }
        public int? SecretTypeId { get; set; }
        public string SecretTypeName { get; set; }
    }
}
