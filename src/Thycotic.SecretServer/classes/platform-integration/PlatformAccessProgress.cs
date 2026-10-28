using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.PlatformIntegration
{
    public class PlatformAccessProgress
    {
        public string IsValidForAutoIdentityPolicy { get; set; }
        public string PlatformDenyPolicyIsConfigured { get; set; }
        public string PlatformDenyPolicyIsEnabled { get; set; }
        public string PoliciesOrderedCorrectly { get; set; }
        public string SecretServerIdentityPolicyConfigured { get; set; }
        public string SecretServerPolicyGroupConfigured { get; set; }
        public string SecretServerPolicyGroupMembershipsApplied { get; set; }
    }
}
