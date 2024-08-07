using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretPermissions
{
    public class Permission
    {
        public string DomainName { get; set; }
        public int GroupId { get; set; }
        public string GroupName { get; set; }
        public int Id { get; set; }
        public string KnownAs { get; set; }
        public int SecretAccessRoleId { get; set; }
        public string SecretAccessRoleName { get; set; }
        public int SecretId { get; set; }
        public int UserId { get; set; }
        public string Username { get; set; }
    }
}
