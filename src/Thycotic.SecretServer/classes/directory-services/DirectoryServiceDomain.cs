using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DirectoryServices
{
    public class DirectoryServiceDomain
    {
        public bool Active { get; set; }
        public int? DomainId { get; set; }
        public string DomainName { get; set; }
        public string FriendlyName { get; set; }
        public bool IsPreventNoUsersLockoutEnabled { get; set; }
        public string MultifactorAuthenticationProvider { get; set; }
        public int SiteId { get; set; }
        public int? SynchronizationSecretId { get; set; }
        public bool UseSecureLDAP { get; set; }
    }
}
