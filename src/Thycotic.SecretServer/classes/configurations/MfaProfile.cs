using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class MfaProfile
    {
        public Guid Id { get; set; }
        public bool IsCurrent { get; set; }
        public string Name { get; set; }
    }
}
