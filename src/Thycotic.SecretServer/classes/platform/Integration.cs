using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Platform
{
    public class Integration
    {
        public bool HasAuthenticatedCurrentUser { get; set; }
        public bool HasIntegrationConfigured { get; set; }
        public bool HasMatchingIntegrationUris { get; set; }
        public bool HasReceivedIntegrationResponse { get; set; }
        public CompatibilityLevel PlatformCompatibilityLevel { get; set; }
    }
}
