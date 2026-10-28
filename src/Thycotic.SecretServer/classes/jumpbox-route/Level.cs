using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.JumpboxRoute
{
    public class Level
    {
        public string JumpboxRouteId { get; set; }
        public int Order { get; set; }
        public int Port { get; set; }
        public int SecretId { get; set; }
    }
}
