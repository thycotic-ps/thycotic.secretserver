using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Groups
{
    public class User
    {
        public int GroupDomainId { get; set; }
        public int GroupId { get; set; }
        public string GroupName { get; set; }
        public int UserDomainId { get; set; }
        public int UserId { get; set; }
        public string Username { get; set; }
    }
}