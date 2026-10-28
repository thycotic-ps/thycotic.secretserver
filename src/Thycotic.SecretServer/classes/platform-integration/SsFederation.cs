using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.PlatformIntegration
{
    public class SsFederation
    {
        public object[] OidcFederations { get; set; }
        public object[] SamlFederations { get; set; }
    }
}
