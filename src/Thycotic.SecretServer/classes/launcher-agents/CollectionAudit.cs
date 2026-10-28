using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.LauncherAgents
{
    public class CollectionAudit
    {
        public string Action { get; set; }
        public string AuditSubject { get; set; }
        public DateTime? Date { get; set; }
        public string DisplayName { get; set; }
        public string FormattedDate { get; set; }
        public PSObject ItemId { get; set; }
        public int LauncherAgentCollectionAuditId { get; set; }
        public int LauncherAgentCollectionId { get; set; }
        public string Notes { get; set; }
        public int UserId { get; set; }
        public string UserName { get; set; }
    }
}
