using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class SamlIdentityProviderCertificate
    {
        public int CertificateId { get; set; }
        public DateTime? Expiration { get; set; }
        public string ExpirationStatus { get; set; }
        public string PublicCertificateThumbprint { get; set; }
        public int SortOrder { get; set; }
    }
}
