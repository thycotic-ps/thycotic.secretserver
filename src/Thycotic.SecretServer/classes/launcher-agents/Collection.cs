using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.LauncherAgents
{
    public class Collection
    {
        public bool Active { get; set; }
        public int ActiveAgentCount { get; set; }
        public DateTime? Created { get; set; }
        public int Id { get; set; }
        public string Name { get; set; }
        public bool RecordKeystrokes { get; set; }
        public bool RecordStandaloneSessions { get; set; }
    }
}
