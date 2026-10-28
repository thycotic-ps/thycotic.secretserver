using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Schedules
{
    public class ScheduleLog
    {
        public string Action { get; set; }
        public DateTime? DurationStartDate { get; set; }
        public DateTime? LogDate { get; set; }
        public int LogLevel { get; set; }
        public string LogMessage { get; set; }
        public int? RecurringScheduleId { get; set; }
        public int RecurringScheduleLogId { get; set; }
        public DateTime? TaskDate { get; set; }
    }
}
