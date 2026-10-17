using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Platform
{
    public class Directory
    {
        public string DirectoryServiceName { get; set; }
        public string DisplayName { get; set; }
        public string PlatformDirectoryServiceUuid { get; set; }
        public string Status { get; set; }
    }
}
