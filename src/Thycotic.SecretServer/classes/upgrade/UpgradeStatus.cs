using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Upgrade
{
    public class UpgradeStatus
    {
        public bool HasOtherNodes { get; set; }
        public bool IsReadOnlyModeEnabled { get; set; }
        public string OtherNodesKbLink { get; set; }
        public UpgradeRunStatus Status { get; set; }
    }
}
