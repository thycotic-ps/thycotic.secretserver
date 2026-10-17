using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.PlatformMigration
{
    public class MigrationUser
    {
        public string DisplayName { get; set; }
        public int? DomainId { get; set; }
        public string DomainName { get; set; }
        public bool HasTotp { get; set; }
        public bool IsThycoticOne { get; set; }
        public DateTime? LastMigrated { get; set; }
        public string MigrationState { get; set; }
        public string MigrationStateDescription { get; set; }
        public int UserId { get; set; }
        public string UserKnownAs { get; set; }
        public string Username { get; set; }
    }
}
