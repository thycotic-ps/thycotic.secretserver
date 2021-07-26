using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Folders
{
    public class Folder
    {
        public int Id { get; set; }

        public string FolderName { get; set; }
        public string FolderPath { get; set; }
        public int ParentFolderId { get; set; }
        public int FolderTypeId { get; set; }
        public int SecretPolicyId { get; set; }
        public bool InheritSecretPolicy { get; set; }
        public bool InheritPermissions { get; set; }
        public Folder[] ChildFolders { get; set; }
        public FolderTemplate[] SecretTemplates { get; set; }
    }
}