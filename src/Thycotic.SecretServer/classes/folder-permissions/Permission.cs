using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.FolderPermissions
{
    public class Permission
    {
        public int FolderAccessRoleId {get;set;}
        public string FolderAccessRoleName {get;set;}
        public int FolderId {get;set;}
        public int GroupId {get;set;}
        public string GroupName {get;set;}
        public int Id {get;set;}
        public string KnownAs {get;set;}
        public int SecretAccessRoleId {get;set;}
        public string SecretAccessRoleName {get;set;}
        public int UserId {get;set;}
        public string Username {get;set;}
    }
}