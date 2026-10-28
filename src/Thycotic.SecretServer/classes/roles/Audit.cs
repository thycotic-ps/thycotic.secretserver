using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Roles
{
    public class Audit
    {
        public string Action { get; set; }
        public string AuditType { get; set; }
        public string DatabaseName { get; set; }
        public DateTime? DateRecorded { get; set; }
        public int Id { get; set; }
        public string MachineName { get; set; }
        public string Notes { get; set; }
        public string UserName { get; set; }
    }
}
