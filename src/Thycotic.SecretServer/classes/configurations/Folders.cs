using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class Folders
    {
        public bool EnablePersonalFolders { get; set; }
        public string PersonalFolderName { get; set; }
        public string PersonalFolderNameOption { get; set; }
        public string PersonalFolderWarning { get; set; }
        public bool RequireViewFolderPermission { get; set; }
        public bool ShowPersonalFolderWarning { get; set; }
    }
}