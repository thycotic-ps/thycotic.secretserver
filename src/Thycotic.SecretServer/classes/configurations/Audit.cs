using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class Audit
    {
        public string Action { get; set; }
        public DateTime? Date { get; set; }
        public string DisplayName { get; set; }
        public string Notes { get; set; }
    }
}