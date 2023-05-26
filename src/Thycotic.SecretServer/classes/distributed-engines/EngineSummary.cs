using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using Thycotic.PowerShell.Enums;

namespace Thycotic.PowerShell.DistributedEngines
{
    public class EngineSummary
    {
        public EngineActivationStatus ActivationStatus { get; set; }
        public string BindAddress { get; set; }
        public EngineConnectionStatus ConnectionStatus { get; set; }
        public int EngineId { get; set; }
        public string FriendlyName { get; set; }
        public string Hostname { get; set; }
        public bool IsBlockedByNet48 { get; set; }
        public DateTime? LastConnected { get; set; }
        public bool canCancelUpdateVersion { get; set; }
        public bool canUpdateVersion { get; set; }
        public string currentVersion { get; set; }
        public string latestVersion { get; set; }
        public bool pendingUpdate { get; set; }
        public bool timeMismatch { get; set; }
        public int timeMismatchSeconds { get; set; }
    }
}