using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Teams
{
    public class Audit
    {
        public string Action { get; set; }
        public string DatabaseName { get; set; }
        public DateTime? DateRecorded { get; set; }
        public int? DelegatedUserId { get; set; }
        public string DisplayName { get; set; }
        public string IpAddress { get; set; }
        public string MachineName { get; set; }
        public string Notes { get; set; }
        public int TeamAuditId { get; set; }
        public int TeamId { get; set; }
        public int UserId { get; set; }
        public string UserName { get; set; }
    }
}
