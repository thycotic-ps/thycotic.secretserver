using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.PlatformMigration
{
    public class PlatformPreCheckFederatedUserSource
    {
        public object[] Errors { get; set; }
        public int TotalOidcs { get; set; }
        public int TotalSaml { get; set; }
        public int ValidOidcs { get; set; }
        public int ValidSaml { get; set; }
    }
}
