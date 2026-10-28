using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Secrets
{
    public class SecurityApproval
    {
        public PSObject Model { get; set; }
        public bool Success { get; set; }
    }
}
