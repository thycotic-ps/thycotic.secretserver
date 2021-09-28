using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.IpRestrictions
{
    public class Group
    {
        public int GroupId { get; set; }
        public string GroupName { get; set; }
        public int Id { get; set; }
        public int IpAddressRestrictionId { get; set; }
        public string IpAddressRestrictionName { get; set; }
    }
}