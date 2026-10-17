using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.ServerNodes
{
    public class StateUpdate
    {
        public bool IsClusteringEnabled { get; set; }
        public bool IsSqlServerReplicationAllowed { get; set; }
        public bool IsSqlServerReplicationEnabled { get; set; }
        public bool RequiresRestart { get; set; }
    }
}
