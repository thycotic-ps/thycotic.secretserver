using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class Backup
    {
        public string BackupDatabasePath { get; set; }
        public bool BackupFailureNotification { get; set; }
        public string BackupPath { get; set; }
        public DateTime? BackupStartDateTime { get; set; }
        public int ConfigurationSqlBackupTimeoutMinutes { get; set; }
        public bool CopyOnlyDatabaseBackup { get; set; }
        public bool EnableDatabaseBackup { get; set; }
        public bool EnableScheduledBackup { get; set; }
        public bool EnableTmsBackup { get; set; }
        public bool EnableWebApplicationBackup { get; set; }
        public int NumberOfBackupsToKeep { get; set; }
        public int RepeatDays { get; set; }
        public int RepeatHours { get; set; }
        public int RepeatMinutes { get; set; }
        public string TmsInstallationPath { get; set; }
    }
}