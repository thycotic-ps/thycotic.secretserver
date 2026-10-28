using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Teams
{
    public class MemberSummary
    {
        public string DisplayName { get; set; }
        public string DomainName { get; set; }
        public int GroupId { get; set; }
        public int TeamId { get; set; }
        public int? UserId { get; set; }
        public string Username { get; set; }
    }
}
