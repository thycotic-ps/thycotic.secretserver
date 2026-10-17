using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DistributedEngines
{
    public class SiteConnectivity
    {
        public string ValidationMessage { get; set; }
        public bool ValidationSuccess { get; set; }
    }
}
