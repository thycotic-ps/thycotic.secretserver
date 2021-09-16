using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using Thycotic.PowerShell.Enums;

namespace Thycotic.PowerShell.Discovery
{
    public class Status
    {
        public DiscoveryActionType[] Actions { get; set; }
        public DateTime? ComputerScanEndDateTime { get; set; }
        public DateTime? ComputerScanStartDateTime { get; set; }
        public DateTime? DiscoveryEndDateTime { get; set; }
        public DateTime? DiscoveryStartDateTime { get; set; }
        public int DiscoverySourceCount { get; set; }
        public bool IsComputerScanRunning { get; set; }
        public bool IsDiscoveryEnabled { get; set; }
        public bool IsDiscoveryRunning { get; set; }
        public DateTime? NextComputerScanStart { get; set; }
        public DateTime? NextDiscoveryStart { get; set; }
    }
}