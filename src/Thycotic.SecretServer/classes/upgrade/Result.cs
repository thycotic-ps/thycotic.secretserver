using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Upgrade
{
    public class Result
    {
        public int ElapsedSeconds { get; set; }
        public string ExpectedVersion { get; set; }
        public string FinalVersion { get; set; }
        public string StartVersion { get; set; }
        public UpgradeRunStatus Status { get; set; }
        public bool Success { get; set; }
    }
}
