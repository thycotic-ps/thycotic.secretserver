using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.EraseRequests
{
    public class Request
    {
        public bool CanApproveOrDeny { get; set; }
        public bool CanCancel { get; set; }
        public DateTime? EraseAfter { get; set; }
        public int Id { get; set; }
        public string RequestComment { get; set; }
        public DateTime? RequestDate { get; set; }
        public int RequestUserId { get; set; }
        public string RequestUserName { get; set; }
        public string ResponseComment { get; set; }
        public string ReviewStatusMessage { get; set; }
        public int SecretCount { get; set; }
        public int Status { get; set; }
        public string StatusDescription { get; set; }
        public DateTime? TimeErased { get; set; }
        public int? WorkflowInstanceId { get; set; }
    }
}
