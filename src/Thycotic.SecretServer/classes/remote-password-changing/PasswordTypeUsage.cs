using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Rpc
{
    public class PasswordTypeUsage
    {
        public int ActiveSecretCount { get; set; }
        public int PasswordTypeId { get; set; }
        public string PasswordTypeName { get; set; }
    }
}
