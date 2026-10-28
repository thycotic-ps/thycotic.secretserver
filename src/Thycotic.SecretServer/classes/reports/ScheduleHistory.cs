using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Reports
{
    public class ScheduleHistory
    {
        public DateTime? DateRun { get; set; }
        public string Format { get; set; }
        public string ReportHtml { get; set; }
    }
}
