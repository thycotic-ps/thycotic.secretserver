using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Proxy
{
    public class Audit
    {
        public string Action { get; set; }
        public DateTime? DateRecorded { get; set; }
        public string DisplayName { get; set; }
        public string IpAddress { get; set; }
        public string Notes { get; set; }
    }
}
