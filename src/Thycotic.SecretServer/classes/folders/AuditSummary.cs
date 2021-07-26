using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Folders
{
    public class AuditSummary
    {
        public string Action { get; set; }
        public int AuditFolderId { get; set; }
        public DateTime? DateRecorded { get; set; }
        public string DisplayName { get; set; }
        public string Notes { get; set; }
    }
}