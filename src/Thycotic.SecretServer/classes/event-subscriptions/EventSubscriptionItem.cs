using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.EventSubscriptions
{
    public class EventSubscriptionItem
    {
        public bool Active { get; set; }
        public int EventSubscriptionId { get; set; }
        public string Name { get; set; }
    }
}
