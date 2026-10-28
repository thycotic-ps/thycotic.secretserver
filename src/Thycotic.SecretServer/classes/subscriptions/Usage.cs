using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Subscriptions
{
    public class Usage
    {
        public int MaxNumberOfDefaultEngines { get; set; }
        public bool MaxNumberOfEnginesUnlimited { get; set; }
        public int MaxNumberOfNonDefaultEngines { get; set; }
        public int MaxNumberOfSecrets { get; set; }
        public int MaxNumberOfSites { get; set; }
        public bool MaxNumberOfSitesUnlimited { get; set; }
        public int MaxNumberOfUsers { get; set; }
        public int MaxSessionMonitoringSecrets { get; set; }
        public bool MaxSessionMonitoringSecretsUnlimited { get; set; }
        public int MaxSessionMonitoringStorage { get; set; }
        public int NumberOfDefaultEngines { get; set; }
        public int NumberOfNonDefaultEngines { get; set; }
        public int NumberOfSecrets { get; set; }
        public int NumberOfSites { get; set; }
        public int NumberOfUsers { get; set; }
        public int SessionMonitoringSecrets { get; set; }
        public double SessionMonitoringStorage { get; set; }
        public bool SitesManagedInPlatform { get; set; }
        public Subscription[] Subscriptions { get; set; }
    }
}
