using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Roles
{
    public class Group
    {
        public DateTime? Created { get; set; }
        public string DisplayName { get; set; }
        public string DomainName { get; set; }
        public bool Enabled { get; set; }
        public int GroupId { get; set; }
        public string Name { get; set; }
        public bool Personal { get; set; }
    }
}
