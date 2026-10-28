using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class ComputerDeleteResult
    {
        public int ComputerId { get; set; }
        public string ComputerName { get; set; }
        public bool Success { get; set; }
    }
}
