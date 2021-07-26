using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Reports
{
    public class ScheduleSummary
    {
        public string ChangeType { get; set; }
        public bool Deleted { get; set; }
        public string Description { get; set; }
        public DateTime? LastRun { get; set; }
        public int LastRunHistoryId { get; set; }
        public string Name { get; set; }
        public int ReportId { get; set; }
        public string ReportName { get; set; }
        public int ScheduleReportId { get; set; }
        public bool SendEmail { get; set; }
        public int StoredReportCount { get; set; }
    }
}