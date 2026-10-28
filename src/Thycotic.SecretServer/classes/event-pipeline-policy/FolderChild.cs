using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.EventPipelinePolicy
{
    public class FolderChild
    {
        public int ChildFolderCount { get; set; }
        public int FolderId { get; set; }
        public bool HasPipelinePolicy { get; set; }
    }
}
