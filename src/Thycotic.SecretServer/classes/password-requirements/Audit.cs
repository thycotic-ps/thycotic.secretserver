using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.PasswordRequirements
{
    public class Audit
    {
        public string Action { get; set; }
        public DateTime? DateRecorded { get; set; }
        public string DisplayName { get; set; }
        public string Notes { get; set; }
        public int PasswordRequirementAuditId { get; set; }
        public int PasswordRequirementId { get; set; }
        public int UserId { get; set; }
        public string UserName { get; set; }
    }
}
