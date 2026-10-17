using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DirectoryServices
{
    public class Configuration
    {
        public int DaysToKeepOperationalLogs { get; set; }
        public int DisableInactiveUsersMonths { get; set; }
        public bool EnableDirectoryIntegration { get; set; }
        public bool EnableDirectorySynchronization { get; set; }
        public bool EnableIntegratedWindowsAuthentication { get; set; }
        public bool EnableUserDisabling { get; set; }
        public int SynchronizationIntervalDays { get; set; }
        public int SynchronizationIntervalHours { get; set; }
        public int SynchronizationIntervalMinutes { get; set; }
        public string UserAccountOptions { get; set; }
    }
}
