using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SqlServerReplication
{
    public class SqlReplication
    {
        public int ActiveDatabasesCount { get; set; }
        public object[] Articles { get; set; }
        public bool HasReplicationLicense { get; set; }
        public bool IsReplicationEnabled { get; set; }
        public int MaxDatabasesAllowed { get; set; }
        public object[] Publications { get; set; }
        public string[] ReplicatedDatabases { get; set; }
    }
}
