using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Rpc
{
    public class CustomCommandTestResult
    {
        public string ConsoleOutput { get; set; }
        public string ErrorMessage { get; set; }
        public bool Success { get; set; }
    }
}
