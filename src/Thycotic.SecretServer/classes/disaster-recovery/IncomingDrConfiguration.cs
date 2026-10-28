using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DisasterRecovery
{
    public class IncomingDrConfiguration
    {
        public string DataReplicaName { get; set; }
        public bool DataReplicationEnabled { get; set; }
        public string DataSourceCertificatePinningKeyHashSha256 { get; set; }
        public string DataSourceKey { get; set; }
        public string DataSourceUrl { get; set; }
        public bool ForceLegacyReplication { get; set; }
        public bool? IsReplica { get; set; }
        public bool IsReplicating { get; set; }
        public DateTime? LastReplicated { get; set; }
        public int ReplicationIntervalMinutes { get; set; }
        public string ReplicationStatus { get; set; }
        public string UserAccountOption { get; set; }
    }
}
