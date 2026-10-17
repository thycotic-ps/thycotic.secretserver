using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.PlatformMigration
{
    public class PlatformPreCheckDomain
    {
        public object[] Errors { get; set; }
        public int TotalDomains { get; set; }
        public int ValidDomains { get; set; }
    }
}
