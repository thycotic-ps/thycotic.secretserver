using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.BulkOperations
{
    public class BulkOperation
    {
        public string BulkOperationDisplayName { get; set; }
        public int BulkOperationId { get; set; }
        public string BulkOperationName { get; set; }
        public string Category { get; set; }
        public int CompletedItems { get; set; }
        public DateTime? EndDate { get; set; }
        public DateTime? StartDate { get; set; }
        public string StartUserDisplayName { get; set; }
        public string StartUserDomain { get; set; }
        public string StartUserName { get; set; }
        public string Status { get; set; }
        public string StopUserDisplayName { get; set; }
        public string StopUserDomain { get; set; }
        public string StopUserName { get; set; }
        public string TaskIdentifier { get; set; }
        public int TotalItems { get; set; }
    }
}
