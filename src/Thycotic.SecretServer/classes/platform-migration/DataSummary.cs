using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.PlatformMigration
{
    public class DataSummary
    {
        public int ExcludedGroupCount { get; set; }
        public int ExcludedUserCount { get; set; }
        public int? LastMigrationErrorCount { get; set; }
        public int? LastMigrationSuccessCount { get; set; }
        public int MigratedGroups { get; set; }
        public int MigratedRoles { get; set; }
        public int MigratedUsers { get; set; }
        public bool MigrateUserTOTPSettings { get; set; }
        public int TotalGroups { get; set; }
        public int TotalRoles { get; set; }
        public int TotalUsers { get; set; }
    }
}
