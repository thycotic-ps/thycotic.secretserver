using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class StateSection
    {
        public string SectionAccess { get; set; }
        public string SectionId { get; set; }
    }
}
