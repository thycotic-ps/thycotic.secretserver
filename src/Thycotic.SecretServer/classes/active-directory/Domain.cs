using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.ActiveDirectory
{
    public class Domain
    {
        public bool Active { get; set; }
        public string AuthType { get; set; }
        public PSObject AzureAdDomainConfiguration { get; set; }
        public string BaseDN { get; set; }
        public string ConcurrencyId { get; set; }
        public int ConfigurationId { get; set; }
        public string DistinguishedName { get; set; }
        public int DomainId { get; set; }
        public string DomainName { get; set; }
        public string DomainType { get; set; }
        public string DomainUsername { get; set; }
        public string FriendlyName { get; set; }
        public bool IsPreventNoUsersLockoutEnabled { get; set; }
        public string NetBIOSName { get; set; }
        public bool RequireDuoAuthentication { get; set; }
        public bool RequireEmailAuthentication { get; set; }
        public bool RequireFido2Authentication { get; set; }
        public bool RequireOATHAuthentication { get; set; }
        public bool RequireRadiusAuthentication { get; set; }
        public int SiteId { get; set; }
        public int? SyncSecretId { get; set; }
        public bool UseAES256 { get; set; }
        public string UserAuthType { get; set; }
        public bool UseSecureLDAP { get; set; }
    }
}
