using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using Thycotic.PowerShell.Enums;

namespace Thycotic.PowerShell.Reports
{
    public class ScheduleView
    {
        public string AdditionalEmailAddresses { get; set; }
        public ReportScheduleType ChangeType { get; set; }
        public int Days { get; set; }
        public Subscriber[] EmailGroups { get; set; }
        public bool Friday { get; set; }
        public bool HealthCheck { get; set; }
        public int HistorySize { get; set; }
        public bool Monday { get; set; }
        public string MonthlyDay { get; set; }
        public int MonthlyDayOfMonth { get; set; }
        public string MonthlyDayOrder { get; set; }
        public int MonthlyDayOrderRecurrence { get; set; }
        public int MonthlyDayRecurrence { get; set; }
        public string MonthlyScheduleType { get; set; }
        public bool Saturday { get; set; }
        public string ScheduleName { get; set; }
        public bool SendEmail { get; set; }
        public bool SendEmailWithHighPriority { get; set; }
        public DateTime? StartingOn { get; set; }
        public bool Sunday { get; set; }
        public bool Thursday { get; set; }
        public bool Tuesday { get; set; }
        public bool Wednesday { get; set; }
        public int Weeks { get; set; }
    }
}