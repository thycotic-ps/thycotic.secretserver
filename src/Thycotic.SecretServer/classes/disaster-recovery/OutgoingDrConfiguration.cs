using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DisasterRecovery
{
    public class OutgoingDrConfiguration
    {
        public string DataPackageStoragePath { get; set; }
        public DataReplication[] DataReplicas { get; set; }
        public string DataSourceKey { get; set; }
        public string DataSourceUrl { get; set; }
        public bool IsDataPackageStoragePathValid { get; set; }
        public bool? IsReplica { get; set; }
    }
}
