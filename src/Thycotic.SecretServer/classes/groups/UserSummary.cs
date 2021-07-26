using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Groups
{
    public class UserSummary
    {
        public string DisplayName { get; set; }
        public bool Enabled { get; set; }
        public int GroupDomainId { get; set; }
        public string GroupDomainName { get; set; }
        public int GroupId { get; set; }
        public string GroupName { get; set; }
        public int UserDomainId { get; set; }
        public string UserDomainName { get; set; }
        public int UserId { get; set; }
        public string Username { get; set; }
    }
}