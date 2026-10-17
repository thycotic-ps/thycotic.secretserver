using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Diagnostics
{
    public class LogEntry
    {
        public string CreatedOn { get; set; }
        public string MachineName { get; set; }
        public string Text { get; set; }
        public string ThreadName { get; set; }
    }
}
