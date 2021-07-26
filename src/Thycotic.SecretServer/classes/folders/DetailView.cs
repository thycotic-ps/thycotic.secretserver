using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Folders
{
    public class DetailView
    {
        public string[] Actions { get; set; }
        public DetailTemplateView[] AllowedTemplates { get; set; }
        public string FolderWarning { get; set; }
        public int Id { get; set; }
        public string Name { get; set; }
    }
}
