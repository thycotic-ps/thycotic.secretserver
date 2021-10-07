using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Diagnostics
{
    public class BackgroundProcess
    {
        public string ApplicationName { get; set; }
        public string Hostname { get; set; }
        public string IdentityName { get; set; }
        public DateTime? LastActivity { get; set; }
        public int ManagedThreadId { get; set; }
        public string ThreadName { get; set; }
    }
}