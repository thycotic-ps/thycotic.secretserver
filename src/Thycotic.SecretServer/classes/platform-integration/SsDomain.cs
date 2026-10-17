using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.PlatformIntegration
{
    public class SsDomain
    {
        public int DomainId { get; set; }
        public string DomainName { get; set; }
        public object[] EngineHosts { get; set; }
        public string FriendlyName { get; set; }
        public bool IsAzure { get; set; }
    }
}
