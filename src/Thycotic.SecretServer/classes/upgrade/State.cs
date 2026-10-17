using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Upgrade
{
    public class State
    {
        public bool AppPoolHasDiskAccessApplication { get; set; }
        public bool AppPoolHasDiskAccessTemp { get; set; }
        public bool CanInstallDownloadedVersion { get; set; }
        public bool CanSetReadOnlyMode { get; set; }
        public bool CanUpgradeWithZeroDowntime { get; set; }
        public string[] ConfirmationMessages { get; set; }
        public string CurrentVersion { get; set; }
        public string DatabaseName { get; set; }
        public string DatabaseServerName { get; set; }
        public string DenyInstallMessage { get; set; }
        public string DownloadedPatchVersionName { get; set; }
        public bool EarlyAdopterEnabled { get; set; }
        public string EncryptionConfigLocation { get; set; }
        public bool IsAbleToConnectToDownload { get; set; }
        public bool IsLatestVersion { get; set; }
        public bool IsLatestVersionAlreadyDownloaded { get; set; }
        public bool IsLicenseEligibleForSupport { get; set; }
        public bool IsPatchVersionDownloaded { get; set; }
        public bool IsReadOnlyModeEnabled { get; set; }
        public bool IsSqlReplicationEnabled { get; set; }
        public DateTime? LastBackupDate { get; set; }
        public string LatestVersionToDownload { get; set; }
        public string LicenseIneligibleSupportMessage { get; set; }
    }
}
