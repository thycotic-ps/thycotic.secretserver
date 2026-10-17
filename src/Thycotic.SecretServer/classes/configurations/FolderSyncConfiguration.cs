using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class FolderSyncConfiguration
    {
        public string CompanyId { get; set; }
        public int DaysToKeepOperationalLogs { get; set; }
        public string FolderStructure { get; set; }
        public int? IntegratorCredentials { get; set; }
        public string IntegratorCredentialsName { get; set; }
        public int IntervalDays { get; set; }
        public int IntervalHours { get; set; }
        public int IntervalMinutes { get; set; }
        public string SiteUrl { get; set; }
        public string SqlCustomView { get; set; }
        public string SqlPassword { get; set; }
        public string SqlServerLocation { get; set; }
        public string SqlUsername { get; set; }
        public bool SyncAllFolders { get; set; }
        public int? SyncFolderId { get; set; }
        public string SyncMethodType { get; set; }
    }
}
