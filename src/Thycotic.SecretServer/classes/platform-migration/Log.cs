using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.PlatformMigration
{
    public class Log
    {
        public int? EntityId { get; set; }
        public string EntityType { get; set; }
        public int LogId { get; set; }
        public string LogLevel { get; set; }
        public string LogLevelDescription { get; set; }
        public DateTime? MigrationDate { get; set; }
        public int? MigrationId { get; set; }
        public string MigrationObjectType { get; set; }
        public string Notes { get; set; }
        public string UserDisplayName { get; set; }
    }
}
