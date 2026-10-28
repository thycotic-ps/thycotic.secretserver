using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class BaseScanner
    {
        public bool Active { get; set; }
        public int ScannerId { get; set; }
        public string ScannerTypeName { get; set; }
        public int[] SupportsDiscoveryScanTypeId { get; set; }
    }
}
