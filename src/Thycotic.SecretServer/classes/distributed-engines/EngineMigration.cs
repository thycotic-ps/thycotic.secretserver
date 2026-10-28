using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DistributedEngines
{
    public class EngineMigration
    {
        public string ErrorMessage { get; set; }
        public bool Success { get; set; }
    }
}
