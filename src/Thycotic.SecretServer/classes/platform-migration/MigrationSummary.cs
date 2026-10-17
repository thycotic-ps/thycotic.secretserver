using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.PlatformMigration
{
    public class MigrationSummary
    {
        public DateTime? EndDate { get; set; }
        public int GroupErrorCount { get; set; }
        public int GroupSuccessCount { get; set; }
        public int MigrationId { get; set; }
        public string MigrationStatus { get; set; }
        public string MigrationStatusDescription { get; set; }
        public int RoleErrorCount { get; set; }
        public int RoleSuccessCount { get; set; }
        public DateTime? StartDate { get; set; }
        public int TotalMigrationObjects { get; set; }
        public string UserDisplayName { get; set; }
        public int UserErrorCount { get; set; }
        public int UserSuccessCount { get; set; }
    }
}
