using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.PasswordRequirements
{
    public class PasswordRequirementItem
    {
        public string Description { get; set; }
        public bool IsDefault { get; set; }
        public string Name { get; set; }
        public int PasswordRequirementId { get; set; }
    }
}
