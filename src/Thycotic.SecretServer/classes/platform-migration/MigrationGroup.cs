using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.PlatformMigration
{
    public class MigrationGroup
    {
        public int? DomainId { get; set; }
        public string DomainName { get; set; }
        public int GroupId { get; set; }
        public string GroupKnownAs { get; set; }
        public string GroupTypeId { get; set; }
        public DateTime? LastMigrated { get; set; }
        public string MigrationState { get; set; }
        public string MigrationStateDescription { get; set; }
        public string Name { get; set; }
        public int NumberOfMembers { get; set; }
        public int NumberOfMigratedMembers { get; set; }
        public bool SystemGroup { get; set; }
    }
}
