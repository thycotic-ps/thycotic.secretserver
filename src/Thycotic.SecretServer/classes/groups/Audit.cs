using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Groups
{
    public class Audit
    {
        public string Action { get; set; }
        public DateTime? DateRecorded { get; set; }
        public string Notes { get; set; }
        public string UserDisplayName { get; set; }
        public int UserId { get; set; }
    }
}
