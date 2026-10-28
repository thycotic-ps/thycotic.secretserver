using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class AccountRuleState
    {
        public bool EmailEnabled { get; set; }
        public bool RpcEnabled { get; set; }
    }
}
