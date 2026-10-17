using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.EventSubscriptions
{
    public class Stub
    {
        public bool SendEmail { get; set; }
        public bool SendSlack { get; set; }
    }
}
