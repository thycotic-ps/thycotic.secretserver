using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Folders
{
    public class TemplateAssociation
    {
        public bool Associated { get; set; }
        public int FolderId { get; set; }
        public int TemplateId { get; set; }
    }
}
