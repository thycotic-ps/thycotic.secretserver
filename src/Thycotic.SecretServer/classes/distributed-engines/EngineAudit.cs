using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DistributedEngines
{
    public class EngineAudit
    {
        public string Action { get; set; }
        public int AuditId { get; set; }
        public DateTime? DateRecorded { get; set; }
        public string EngineName { get; set; }
        public string Notes { get; set; }
        public string User { get; set; }
    }
}
