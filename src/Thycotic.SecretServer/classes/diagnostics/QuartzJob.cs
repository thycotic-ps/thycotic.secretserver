using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Diagnostics
{
    public class QuartzJob
    {
        public string JobName { get; set; }
        public long NextFireTicks { get; set; }
        public DateTime? NextFireTime { get; set; }
        public long PreviousFireTicks { get; set; }
        public DateTime? PreviousFireTime { get; set; }
        public string TriggerState { get; set; }
    }
}
