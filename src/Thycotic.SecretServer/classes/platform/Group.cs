using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Platform
{
    public class Group
    {
        public string DomainName { get; set; }
        public string DsGuid { get; set; }
        public string GroupType { get; set; }
        public string Name { get; set; }
    }
}
