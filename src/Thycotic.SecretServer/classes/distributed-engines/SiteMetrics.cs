using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DistributedEngines
{
    public class SiteMetrics
    {
        public string MetricDisplayName { get; set; }
        public string MetricName { get; set; }
        public int MetricValue { get; set; }
    }
}