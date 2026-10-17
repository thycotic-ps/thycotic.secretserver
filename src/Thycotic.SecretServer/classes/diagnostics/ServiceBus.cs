using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Diagnostics
{
    public class ServiceBus
    {
        public string ServiceBusName { get; set; }
        public string ServiceBusUrl { get; set; }
    }
}
