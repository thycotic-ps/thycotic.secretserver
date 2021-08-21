using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class SamlProvider
    {
        public bool Active { get; set; }
        public string AuthnContext { get; set; }
        public int ClockSkew { get; set; }
        public string Description { get; set; }
        public bool DisableAssertionReplayCheck { get; set; }
        public bool DisableAudienceRestrictionCheck { get; set; }
        public bool DisableAuthnContextCheck { get; set; }
        public bool DisableDestinationCheck { get; set; }
        public bool DisableInboundLogout { get; set; }
        public bool DisableInResponseToCheck { get; set; }
        public bool DisablePendingLogoutCheck { get; set; }
        public bool DisableRecipientCheck { get; set; }
        public bool DisableTimePeriodCheck { get; set; }
        public string DisplayName { get; set; }
        public string DomainAttribute { get; set; }
        public bool EnableDetailedLog { get; set; }
        public bool EnableSLO { get; set; }
        public bool ForceAuthentication { get; set; }
        public int IdentityProviderId { get; set; }
        public int LogoutRequestLifeTime { get; set; }
        public string Name { get; set; }
        public bool OverridePendingAuthnRequest { get; set; }
        public string PublicCertificate { get; set; }
        public bool SignAuthnRequest { get; set; }
        public bool SignLogoutRequest { get; set; }
        public bool SignLogoutResponse { get; set; }
        public string SingleLogoutServiceResponseUrl { get; set; }
        public string SingleLogoutServiceUrl { get; set; }
        public int SsoServiceBinding { get; set; }
        public string SsoServiceUrl { get; set; }
        public string UsernameAttribute { get; set; }
        public bool WantAssertionEncrypted { get; set; }
        public bool WantAssertionOrResponseSigned { get; set; }
        public bool WantAssertionSigned { get; set; }
        public bool WantLogoutRequestSigned { get; set; }
        public bool WantLogoutResponseSigned { get; set; }
        public bool WantSAMLResponseSigned { get; set; }
    }
}