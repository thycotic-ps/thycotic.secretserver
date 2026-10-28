using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Secrets
{
    public class ForceCheckoutDetail
    {
        public bool IsRequestAlreadyApproved { get; set; }
        public string RequesterName { get; set; }
        public string SecretName { get; set; }
    }
}
