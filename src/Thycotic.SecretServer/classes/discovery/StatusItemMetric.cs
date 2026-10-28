using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class StatusItemMetric
    {
        public string ItemType { get; set; }
        public string ItemTypeDisplayName { get; set; }
        public int ManagedCount { get; set; }
        public int NotManagedCount { get; set; }
    }
}
