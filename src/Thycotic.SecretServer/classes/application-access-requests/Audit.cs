using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.ApplicationAccessRequests
{
    public class Audit
    {
        public string Action { get; set; }
        public string DatabaseName { get; set; }
        public DateTime? DateRecorded { get; set; }
        public string IpAddress { get; set; }
    }
}
