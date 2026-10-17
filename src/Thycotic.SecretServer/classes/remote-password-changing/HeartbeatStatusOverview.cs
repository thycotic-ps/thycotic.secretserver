using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Rpc
{
    public class HeartbeatStatusOverview
    {
        public int? FailedHeartbeatReportId { get; set; }
        public int? HeartbeatStatusHistoryReportId { get; set; }
        public int? PendingHeartbeatReportId { get; set; }
        public HeartbeatStatusCount[] Statuses { get; set; }
    }
}
