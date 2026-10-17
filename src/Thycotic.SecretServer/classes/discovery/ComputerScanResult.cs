using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class ComputerScanResult
    {
        public int ComputerId { get; set; }
        public string ComputerName { get; set; }
        public ComputerScanStatus[] Statuses { get; set; }
        public bool Success { get; set; }
    }
}
