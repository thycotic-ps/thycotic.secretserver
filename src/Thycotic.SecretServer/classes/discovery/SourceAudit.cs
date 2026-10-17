using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class SourceAudit
    {
        public string Action { get; set; }
        public DateTime? Date { get; set; }
        public int DiscoverySourceAuditId { get; set; }
        public int DiscoverySourceId { get; set; }
        public string DisplayName { get; set; }
        public string FormattedDate { get; set; }
        public int ItemId { get; set; }
        public string Notes { get; set; }
        public int UserId { get; set; }
        public string UserName { get; set; }
    }
}
