using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.EraseRequests
{
    public class History
    {
        public string Action { get; set; }
        public DateTime? DateRecorded { get; set; }
        public string Details { get; set; }
        public string FullName { get; set; }
    }
}
