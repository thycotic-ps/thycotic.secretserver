using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Rpc
{
    public class CustomCommand
    {
        public string Command { get; set; }
        public int CommandTypeCode { get; set; }
        public string Comment { get; set; }
        public string ConcurrencyId { get; set; }
        public int CustomCommandId { get; set; }
        public int Order { get; set; }
        public int PasswordTypeId { get; set; }
        public int Pause { get; set; }
    }
}
