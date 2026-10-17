using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.HsmConfiguration
{
    public class HsmAudit
    {
        public string Action { get; set; }
        public string Date { get; set; }
        public DateTime? DateTime { get; set; }
        public string DisplayName { get; set; }
        public int HsmConfigurationAuditId { get; set; }
        public string Notes { get; set; }
    }
}
