using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Upgrade
{
    public class ManualUpgradeState
    {
        public string ApplicationFileLocation { get; set; }
        public bool AppPoolHasDiskAccessApplication { get; set; }
        public bool AppPoolHasDiskAccessTemp { get; set; }
        public bool AreSqlDeltasVerified { get; set; }
        public string[] BlockingVersions { get; set; }
        public bool CanSetIgnoreVersionMismatch { get; set; }
        public bool CanSetReadOnlyMode { get; set; }
        public bool CanUpgradeVersion { get; set; }
        public string CurrentVersion { get; set; }
        public string DownloadedPatchVersionName { get; set; }
        public bool HasOtherNodes { get; set; }
        public bool IsApplicationZipFileDownloaded { get; set; }
        public bool IsIgnoreVersionMismatchEnabled { get; set; }
        public bool IsReadOnlyModeEnabled { get; set; }
        public bool IsSqlReplicationEnabled { get; set; }
        public bool IsSqlScriptGenerated { get; set; }
        public bool IsStagingTestSuccessful { get; set; }
        public bool IsUpgradeFinishedOnAllNodes { get; set; }
        public bool IsUpgradeSuccessfulOnCurrentNode { get; set; }
        public string ManualUpgradeZipFileName { get; set; }
        public bool SqlScriptGenerateFailed { get; set; }
        public string TempFileLocation { get; set; }
        public bool UpgradeContainsSqlDeltaUpdates { get; set; }
        public bool VerifySqlScriptFailed { get; set; }
    }
}
