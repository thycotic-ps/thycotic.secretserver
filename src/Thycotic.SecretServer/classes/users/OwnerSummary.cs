using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Users
{
    public class OwnerSummary
    {
        public int DomainId { get; set; }
        public int GroupId { get; set; }
        public int Id { get; set; }
        public bool IsUser { get; set; }
        public string Name { get; set; }
        public int UserId { get; set; }
    }
}