using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.PlatformMigration
{
    public class Progress
    {
        public DateTime? EndDate { get; set; }
        public bool IsRunning { get; set; }
        public bool IsStale { get; set; }
        public int? MigrationId { get; set; }
        public string MigrationStatus { get; set; }
        public int ProcessedItemCount { get; set; }
        public DateTime? StartDate { get; set; }
        public int TotalItemCount { get; set; }
    }
}
