using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class StatusOsMetric
    {
        public string OperatingSystem { get; set; }
        public int OperatingSystemCount { get; set; }
    }
}
