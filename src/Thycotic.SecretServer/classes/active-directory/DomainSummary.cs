using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.ActiveDirectory
{
    public class DomainSummary
    {
        public bool Active { get; set; }
        public string ConcurrencyId { get; set; }
        public string DistinguishedName { get; set; }
        public int DomainId { get; set; }
        public string DomainName { get; set; }
        public string DomainType { get; set; }
        public string FriendlyName { get; set; }
        public bool RequireRadiusAuthentication { get; set; }
        public int SiteId { get; set; }
        public bool UseSecureLdap { get; set; }
    }
}
