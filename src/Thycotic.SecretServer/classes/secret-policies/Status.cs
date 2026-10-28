using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretPolicies
{
    public class Status
    {
        public double InProgressSecretCount { get; set; }
        public double SecretCount { get; set; }
        public double SecretPercentComplete { get; set; }
        public int SecretPolicyId { get; set; }
    }
}
