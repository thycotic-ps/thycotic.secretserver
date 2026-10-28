using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DistributedEngines
{
    public class SiteAudit
    {
        public string Action { get; set; }
        public DateTime? DateRecorded { get; set; }
        public string Notes { get; set; }
        public int SiteAuditId { get; set; }
        public string UserName { get; set; }
    }
}
