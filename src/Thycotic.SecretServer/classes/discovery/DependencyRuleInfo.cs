using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class DependencyRuleInfo
    {
        public object[] DependencyTemplates { get; set; }
        public bool IsPrivilegedSecretRequired { get; set; }
        public int[] PasswordTypeIds { get; set; }
        public object[] SecretTemplates { get; set; }
    }
}
