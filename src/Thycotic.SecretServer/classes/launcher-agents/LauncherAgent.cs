using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.LauncherAgents
{
    public class LauncherAgent
    {
        public bool Active { get; set; }
        public int CollectionId { get; set; }
        public string CollectionName { get; set; }
        public DateTime? Created { get; set; }
        public string HostName { get; set; }
        public int Id { get; set; }
        public DateTime? LastActivity { get; set; }
        public bool? RecordKeystrokes { get; set; }
        public bool? RecordStandaloneSessions { get; set; }
        public string Version { get; set; }
    }
}
