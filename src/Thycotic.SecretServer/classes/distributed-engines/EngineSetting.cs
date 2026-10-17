using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DistributedEngines
{
    public class EngineSetting
    {
        public bool CanEdit { get; set; }
        public bool Display { get; set; }
        public bool Enabled { get; set; }
    }
}
