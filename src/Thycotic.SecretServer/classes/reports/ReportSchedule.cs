using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using Thycotic.PowerShell.Enums;

namespace Thycotic.PowerShell.Reports
{
    public class ReportSchedule
    {
        public string CustomParameterValue { get; set; }
        public DateTime? EndDateParameterSpecificDateValue { get; set; }
        public string EndDateParameterValue { get; set; }
        public ParameterValue FolderParameter { get; set; }
        public ReportFormat Format { get; set; }
        public ParameterValue GroupParameterValue { get; set; }
        public int ReportId { get; set; }
        public string ReportName { get; set; }
        public ScheduleView Schedule { get; set; }
        public int ScheduleReportId { get; set; }
        public DateTime? StartDateParameterSpecificDateValue { get; set; }
        public string StartDateParameterValue { get; set; }
        public ParameterValue UserParameterValue { get; set; }
    }
}