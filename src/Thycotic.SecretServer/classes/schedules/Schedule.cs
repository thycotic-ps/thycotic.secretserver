using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Schedules
{
    public class Schedule
    {
        public bool Active { get; set; }
        public int Duration { get; set; }
        public DateTime? DurationStartDate { get; set; }
        public PSObject Entity { get; set; }
        public string Notes { get; set; }
        public int RecurringScheduleId { get; set; }
        public string RecurringScheduleType { get; set; }
        public object[] ScheduleConstraints { get; set; }
        public string TimeZoneId { get; set; }
    }
}
