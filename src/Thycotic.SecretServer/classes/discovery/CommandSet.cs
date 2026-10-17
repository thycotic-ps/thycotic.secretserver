using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class CommandSet
    {
        public PSObject Actions { get; set; }
        public string Commands { get; set; }
        public int CommandSetId { get; set; }
        public string CommandSetName { get; set; }
        public int DiscoveryScannerId { get; set; }
        public bool IsActive { get; set; }
        public bool IsStandard { get; set; }
        public int ScanTypeId { get; set; }
        public string ScanTypeName { get; set; }
    }
}
