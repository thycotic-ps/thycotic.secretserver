using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.JumpboxRoute
{
    public class JumpboxRouteItem
    {
        public bool Active { get; set; }
        public string Description { get; set; }
        public string JumpboxRouteId { get; set; }
        public string Name { get; set; }
    }
}
