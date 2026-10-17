using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretTemplatePermissions
{
    public class GroupPermission
    {
        public int GroupId { get; set; }
        public object[] Permissions { get; set; }
    }
}
