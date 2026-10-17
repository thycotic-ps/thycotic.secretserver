using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.JumpboxRoute
{
    public class JumpboxRoute
    {
        public bool Active { get; set; }
        public string Description { get; set; }
        public string JumpboxRouteId { get; set; }
        public object[] JumpboxRouteLevels { get; set; }
        public string Name { get; set; }
    }
}
