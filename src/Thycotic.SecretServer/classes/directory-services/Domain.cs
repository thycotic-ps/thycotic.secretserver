using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using Thycotic.PowerShell.Enums;

namespace Thycotic.PowerShell.DirectoryServices
{
    public class Domain
    {
        public bool Active {get;set;}
        public int DomainId { get; set; }
        public string DomainName { get; set; }
        public string FriendlyName { get; set; }
        public MfaProviderType MultifactorAuthenticationProvider { get; set; }
        public int SiteId { get; set; }
        public int SynchronizationSecretId { get; set; }
        public bool UseSecureLdap { get; set; }
    }
}