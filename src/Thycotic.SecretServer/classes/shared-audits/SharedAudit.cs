using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SharedAudits
{
    public class SharedAudit
    {
        public string Action { get; set; }
        public string Application { get; set; }
        public int AuditId { get; set; }
        public int? ChangesetCount { get; set; }
        public string DatabaseName { get; set; }
        public DateTime? DateRecorded { get; set; }
        public int? DelegatedUserId { get; set; }
        public string Endpoint { get; set; }
        public string IpAddress { get; set; }
        public int? ItemId { get; set; }
        public string ItemName { get; set; }
        public string MachineName { get; set; }
        public string Notes { get; set; }
        public string UserDisplayName { get; set; }
        public int UserId { get; set; }
    }
}
