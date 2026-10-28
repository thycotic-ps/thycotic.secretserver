using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Lists
{
    public class Audit
    {
        public string Action { get; set; }
        public int CategorizedListAuditId { get; set; }
        public string CategorizedListId { get; set; }
        public string DatabaseName { get; set; }
        public DateTime? DateRecorded { get; set; }
        public int? DelegatedUserId { get; set; }
        public string DelegatedUserName { get; set; }
        public string DisplayName { get; set; }
        public string FormattedDate { get; set; }
        public string IpAddress { get; set; }
        public string MachineName { get; set; }
        public string Notes { get; set; }
        public int UserId { get; set; }
        public string UserName { get; set; }
    }
}
