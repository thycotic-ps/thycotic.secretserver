using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DistributedEngines
{
    public class SiteSummary
    {
        public bool Active { get; set; }
        public bool IsLocal { get; set; }
        public DateTime? LastActivity { get; set; }
        public int NumEnginesMissingNetFramework { get; set; }
        public int numEnginesWithoutAbilityToRestartService { get; set; }
        public int OfflineEngineCount { get; set; }
        public int OnlineEngineCount { get; set; }
        public int SiteId { get; set; }
        public SiteMetrics[] SiteMetrics { get; set; }
        public string SiteName { get; set; }
    }
}