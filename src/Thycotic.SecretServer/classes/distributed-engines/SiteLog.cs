using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DistributedEngines
{
    public class SiteLog
    {
        public DateTime? DateRecorded { get; set; }
        public string EngineName { get; set; }
        public string Message { get; set; }
    }
}
