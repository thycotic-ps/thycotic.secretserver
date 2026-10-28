using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Reports
{
    public class ScheduleHistorySummary
    {
        public DateTime? DateRun { get; set; }
        public int ScheduleReportHistoryId { get; set; }
    }
}
