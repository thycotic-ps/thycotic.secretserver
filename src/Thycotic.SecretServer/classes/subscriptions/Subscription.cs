using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Subscriptions
{
    public class Subscription
    {
        public string Description { get; set; }
        public string DisplayName { get; set; }
        public DateTime? EndDate { get; set; }
        public string Note { get; set; }
        public string Recurrence { get; set; }
        public DateTime? StartDate { get; set; }
        public int Units { get; set; }
    }
}
