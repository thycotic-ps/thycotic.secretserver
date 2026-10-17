using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.BulkOperations
{
    public class Audit
    {
        public string Action { get; set; }
        public PSObject AffectedSecret { get; set; }
        public PSObject AffectedUser { get; set; }
        public int AuditId { get; set; }
        public int BulkOperationId { get; set; }
        public DateTime? DateRecorded { get; set; }
        public int ItemId { get; set; }
        public string Notes { get; set; }
    }
}
