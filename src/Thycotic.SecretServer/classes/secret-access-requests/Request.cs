using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.AccessRequests
{
    public class Request
    {
        public int AccessRequestWorkflowMapId { get; set; }
        public string ApproverDisplayName { get; set; }
        public bool Completed { get; set; }
        public bool CurrentUserRestrictedFromReviewing { get; set; }
        public DateTime? ExpirationDate { get; set; }
        public int FolderId { get; set; }
        public bool HasWorkflow { get; set; }
        public string RequestComment { get; set; }
        public DateTime? RequestDate { get; set; }
        public int RequestingUserId { get; set; }
        public string RequestUsername { get; set; }
        public string ResponseComment { get; set; }
        public DateTime? ResponseDate { get; set; }
        public string ReviewStatusMessage { get; set; }
        public int SecretAccessRequestId { get; set; }
        public int SecretId { get; set; }
        public string SecretName { get; set; }
        public DateTime? StartDate { get; set; }
        public string Status { get; set; }
        public string StatusDescription { get; set; }
        public string TicketNumber { get; set; }
        public int TicketSystemId { get; set; }
    }
}