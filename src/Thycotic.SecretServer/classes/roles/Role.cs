using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Roles
{
    public class Role
    {
        public DateTime? Created { get; set; }
        public bool Enabled { get; set; }
        public int Id { get; set; }
        public string Name { get; set; }
    }
}