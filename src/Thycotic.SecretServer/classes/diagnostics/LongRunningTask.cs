using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Diagnostics
{
    public class LongRunningTask
    {
        public DateTime? CreateDate { get; set; }
        public DateTime? ExpirationDate { get; set; }
        public string TaskName { get; set; }
        public int? TimeToLive { get; set; }
    }
}
