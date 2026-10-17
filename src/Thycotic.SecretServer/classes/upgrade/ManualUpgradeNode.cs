using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Upgrade
{
    public class ManualUpgradeNode
    {
        public string ErrorMessageCss { get; set; }
        public string ErrorMessageDisplay { get; set; }
        public bool InCluster { get; set; }
        public bool IsCurrentNode { get; set; }
        public DateTime? LastPolledDate { get; set; }
        public string MachineName { get; set; }
        public int NodeId { get; set; }
        public bool ReadOnlyMode { get; set; }
        public string Version { get; set; }
    }
}
