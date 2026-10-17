using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.HealthCheck
{
    public class Status
    {
        public bool? DatabaseHealthy { get; set; }
        public bool DatabaseMismatch { get; set; }
        public bool Healthy { get; set; }
        public DateTime? Now { get; set; }
        public DateTime? ProvisionDeletionDateTime { get; set; }
        public bool ReadOnlyMode { get; set; }
        public bool? ScheduledForDeletion { get; set; }
        public bool? ServiceBusHealthy { get; set; }
        public bool? StorageAccount2Healthy { get; set; }
        public bool? StorageAccountHealthy { get; set; }
        public DateTime? UtcNow { get; set; }
    }
}
