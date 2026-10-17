using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.RestDocumentation
{
    public class Service
    {
        public string Description { get; set; }
        public string ServiceDisplayName { get; set; }
        public string ServiceName { get; set; }
    }
}
