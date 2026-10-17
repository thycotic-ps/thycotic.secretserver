using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class AccountRuleInfo
    {
        public bool IsKeyType { get; set; }
        public int[] PasswordTypeIdsForPasswordChanging { get; set; }
        public object[] PasswordTypesForTakeOver { get; set; }
        public bool RequiresTakeover { get; set; }
        public bool RpcRequiresPrivilege { get; set; }
        public string SecretFieldNameForMachine { get; set; }
        public string TakeOverAccountType { get; set; }
    }
}
