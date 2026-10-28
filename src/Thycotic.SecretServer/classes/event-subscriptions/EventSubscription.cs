using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.EventSubscriptions
{
    public class EventSubscription
    {
        public bool Active { get; set; }
        public object[] EntityActions { get; set; }
        public int EventSeverity { get; set; }
        public int EventSubscriptionId { get; set; }
        public int InboxExpiration { get; set; }
        public object[] Subscribers { get; set; }
        public string SubscriptionName { get; set; }
    }
}
