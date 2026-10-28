using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.RecordedSessions
{
    public class ProcessingRequest
    {
        public PSObject Estimate { get; set; }
        public int Status { get; set; }
        public bool Success { get; set; }
    }
}
