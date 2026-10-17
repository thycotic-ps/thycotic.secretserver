using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.ServerNodes
{
    public class Audit
    {
        public string Action { get; set; }
        public DateTime? Date { get; set; }
        public string DisplayName { get; set; }
        public string FormattedDate { get; set; }
        public int? ItemId { get; set; }
        public int NodeAuditId { get; set; }
        public int NodeId { get; set; }
        public string Notes { get; set; }
        public int UserId { get; set; }
        public string UserName { get; set; }
    }
}
