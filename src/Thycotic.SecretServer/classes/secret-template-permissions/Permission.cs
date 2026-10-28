using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretTemplatePermissions
{
    public class Permission
    {
        public int? DomainId { get; set; }
        public string DomainName { get; set; }
        public int? GroupId { get; set; }
        public string GroupName { get; set; }
        public bool IsPersonalGroup { get; set; }
        public int RoleId { get; set; }
        public string RoleName { get; set; }
        public int? SecretTypeId { get; set; }
        public string SecretTypeName { get; set; }
        public int? UserId { get; set; }
        public string UserName { get; set; }
    }
}
