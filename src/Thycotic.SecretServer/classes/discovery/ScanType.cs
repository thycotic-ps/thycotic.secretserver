using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class ScanType
    {
        public int DiscoveryScanTypeId { get; set; }
        public string ScanTypeDescription { get; set; }
        public string ScanTypeName { get; set; }
    }
}
