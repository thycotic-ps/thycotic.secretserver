using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretPolicies
{
    public class Policy
    {
        public bool Active { get; set; }
        public string SecretPolicyDescription { get; set; }
        public int SecretPolicyId { get; set; }
        public string SecretPolicyName { get; set; }
        public PolicyItem[] SecretPolicyItems { get; set; }
    }
}