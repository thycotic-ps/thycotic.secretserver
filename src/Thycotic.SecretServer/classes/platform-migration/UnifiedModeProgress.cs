using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.PlatformMigration
{
    public class UnifiedModeProgress
    {
        public int FailCount { get; set; }
        public bool IsRunning { get; set; }
        public bool IsStale { get; set; }
        public string Status { get; set; }
        public int SuccessCount { get; set; }
    }
}
