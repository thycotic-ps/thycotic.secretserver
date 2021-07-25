using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DirectoryServices
{
    public class DomainSummary
    {
        public bool Active { get; set; }
        public int DomainId { get; set; }
        public string DomainName { get; set; }
        public string DomainType { get; set; }
        public string FriendlyName { get; set; }
        public bool RequireRadiusAuthentication { get; set; }
        public bool UseSecureLdap { get; set; }
    }
}