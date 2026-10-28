using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.EraseRequests
{
    public class ActionResult
    {
        public string ActionResultMessage { get; set; }
        public PSObject Request { get; set; }
    }
}
