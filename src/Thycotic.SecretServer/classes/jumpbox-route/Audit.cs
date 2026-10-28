using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.JumpboxRoute
{
    public class Audit
    {
        public string Action { get; set; }
        public string AuditId { get; set; }
        public string Date { get; set; }
        public DateTime? DateTime { get; set; }
        public string Notes { get; set; }
        public string UserDisplayName { get; set; }
    }
}
