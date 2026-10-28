using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class ComputerScanStatus
    {
        public string Message { get; set; }
        public string ScanType { get; set; }
        public bool Success { get; set; }
    }
}
