using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class SourceFilter
    {
        public int DiscoverySourceId { get; set; }
        public object[] Filters { get; set; }
        public bool LookupTableIsReady { get; set; }
    }
}
