using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.TicketSystems
{
    public class Override
    {
        public string ApproverDisplayName { get; set; }
        public int? ApproverUserId { get; set; }
        public bool CanApprove { get; set; }
        public string Comment { get; set; }
        public DateTime? CreateDate { get; set; }
        public bool? Enabled { get; set; }
        public DateTime? EnabledDate { get; set; }
        public DateTime? ExpirationDate { get; set; }
        public bool HasExpired { get; set; }
        public string RequestDisplayName { get; set; }
        public string RequestReason { get; set; }
        public int? RequestUserId { get; set; }
        public string RequestUsername { get; set; }
        public int? SecretId { get; set; }
        public string SecretName { get; set; }
        public string TicketNumber { get; set; }
        public int TicketSystemId { get; set; }
        public string TicketSystemName { get; set; }
        public int TicketSystemOverrideId { get; set; }
    }
}
