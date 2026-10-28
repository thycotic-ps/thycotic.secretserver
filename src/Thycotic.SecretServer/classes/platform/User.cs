using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Platform
{
    public class User
    {
        public string DirectoryInstanceName { get; set; }
        public string DirectoryServiceName { get; set; }
        public string DirectoryServiceUuid { get; set; }
        public string DisplayName { get; set; }
        public string Email { get; set; }
        public string PlatformMembershipType { get; set; }
        public string State { get; set; }
        public string UserName { get; set; }
        public string Uuid { get; set; }
    }
}
