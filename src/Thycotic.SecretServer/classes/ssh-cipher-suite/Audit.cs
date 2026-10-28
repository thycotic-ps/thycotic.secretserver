using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SshCipherSuite
{
    public class Audit
    {
        public string Action { get; set; }
        public string AuditId { get; set; }
        public string Date { get; set; }
        public DateTime? DateTime { get; set; }
        public string DisplayName { get; set; }
        public string Notes { get; set; }
    }
}
