using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.PlatformMigration
{
    public class MigrationRole
    {
        public DateTime? LastMigrated { get; set; }
        public string MigrationState { get; set; }
        public string Name { get; set; }
        public int NumberOfAssigments { get; set; }
        public int NumberOfPermissions { get; set; }
        public int RoleId { get; set; }
    }
}
