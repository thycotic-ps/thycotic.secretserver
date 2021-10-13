using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DistributedEngines
{
    public class EngineActivation
    {
        public int EngineId { get; set; }
        public string EngineName { get; set; }
        public string Error { get; set; }
        public bool IsSuccessful { get; set; }
    }
}