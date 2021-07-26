using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Groups
{
    public class GroupOwner
    {
        public int GroupId { get; set; }
        public string Name { get; set; }
        public int UserId { get; set; }
    }
}