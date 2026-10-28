using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecurityAuditLogs
{
    public class SecurityAuditLog
    {
        public string Action { get; set; }
        public string ByUserDisplayName { get; set; }
        public string DatabaseName { get; set; }
        public DateTime? DateRecorded { get; set; }
        public string DateRecordedDisplay { get; set; }
        public string EventEntityType { get; set; }
        public string IpAddress { get; set; }
        public string LogSourceName { get; set; }
        public string MachineName { get; set; }
        public string Notes { get; set; }
    }
}
