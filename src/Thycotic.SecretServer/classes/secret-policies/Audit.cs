using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretPolicies
{
    public class Audit
    {
        public string Action { get; set; }
        public string DatabaseName { get; set; }
        public DateTime? DateRecorded { get; set; }
        public string MachineName { get; set; }
        public string Notes { get; set; }
        public int SecretPolicyAuditId { get; set; }
        public int UserId { get; set; }
        public string Username { get; set; }
    }
}
