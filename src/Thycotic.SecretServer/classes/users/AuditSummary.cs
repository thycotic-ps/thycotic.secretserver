using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Users
{
    public class AuditSummary
    {
        public string Action { get; set; }
        public string DatabaseName { get; set; }
        public DateTime? DateRecorded { get; set; }
        public string DisplayName { get; set; }
        public string DisplayNameAffected { get; set; }
        public string IpAddress { get; set; }
        public string MachineName { get; set; }
        public string Notes { get; set; }
        public int UserId { get; set; }
        public int UserIdAffected { get; set; }
    }
}