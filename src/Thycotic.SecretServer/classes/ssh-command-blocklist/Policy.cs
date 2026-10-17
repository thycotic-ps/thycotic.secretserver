using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SshCommandBlocklist
{
    public class Policy
    {
        public int SecretPolicyId { get; set; }
        public string SecretPolicyName { get; set; }
    }
}
