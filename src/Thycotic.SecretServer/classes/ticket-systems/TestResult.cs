using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.TicketSystems
{
    public class TestResult
    {
        public string ErrorMessage { get; set; }
        public bool Success { get; set; }
    }
}
