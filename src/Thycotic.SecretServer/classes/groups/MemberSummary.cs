using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Groups
{
    public class MemberSummary
    {
        public bool Assigned { get; set; }
        public string DisplayName { get; set; }
        public string DomainName { get; set; }
        public bool Enabled { get; set; }
        public int GroupId { get; set; }
        public int UserId { get; set; }
        public string UserName { get; set; }
    }
}
