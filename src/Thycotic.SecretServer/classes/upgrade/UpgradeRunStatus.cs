using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Upgrade
{
    public class UpgradeRunStatus
    {
        public DateTime? EndDate { get; set; }
        public string EndDateDisplay { get; set; }
        public string ExceptionMessage { get; set; }
        public bool IsRunning { get; set; }
        public bool IsSuccess { get; set; }
        public DateTime? StartDate { get; set; }
        public string StartDateDisplay { get; set; }
        public PSObject[] Tasks { get; set; }
    }
}
