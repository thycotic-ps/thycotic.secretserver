using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.FolderPermissions
{
    public class Summary
    {
        public int FolderAccessRoleId { get; set; }
        public string FolderAccessRoleName { get; set; }
        public int GroupId { get; set; }
        public int SecretAccessRoleId { get; set; }
        public string SecretAccessRoleName { get; set; }
    }
}