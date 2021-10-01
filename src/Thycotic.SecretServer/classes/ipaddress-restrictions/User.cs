using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.IpRestrictions
{
    public class User
    {
        public int Id { get; set; }
        public int IpAddressRestrictionId { get; set; }
        public string IpAddressRestrictionName { get; set; }
        public string UserDisplayName { get; set; }
        public int UserId { get; set; }
        public string Username { get; set; }
    }
}