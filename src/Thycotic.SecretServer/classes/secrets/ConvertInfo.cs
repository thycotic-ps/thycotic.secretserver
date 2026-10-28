using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Secrets
{
    public class ConvertInfo
    {
        public PSObject Destination { get; set; }
        public PSObject Source { get; set; }
    }
}
