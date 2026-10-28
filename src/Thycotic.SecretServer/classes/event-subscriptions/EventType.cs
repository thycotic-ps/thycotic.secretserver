using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.EventSubscriptions
{
    public class EventType
    {
        public object[] Actions { get; set; }
        public object[] ConditionTypeOptions { get; set; }
        public string DisplayName { get; set; }
        public string Entity { get; set; }
        public string Id { get; set; }
    }
}
