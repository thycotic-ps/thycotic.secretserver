using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class Saml
    {
        public bool Enabled { get; set; }
        public bool EnableLegacySlo { get; set; }
        public SamlProvider[] IdentityProviders { get; set; }
        public string LegacyUsernameAttribute { get; set; }
        public string ServiceProviderCertificate { get; set; }
        public string ServiceProviderCertificatePassword { get; set; }
        public string ServiceProviderName { get; set; }
        public bool UseLegacy { get; set; }
    }
}