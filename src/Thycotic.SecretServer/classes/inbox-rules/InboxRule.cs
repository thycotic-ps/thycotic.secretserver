using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.InboxRules
{
    public class InboxRule
    {
        public bool Active { get; set; }
        public bool CanEditOwnSubscription { get; set; }
        public object[] Conditions { get; set; }
        public int CreatedByUserId { get; set; }
        public bool HighPriority { get; set; }
        public int? InboxEmailTemplateId { get; set; }
        public object[] InboxMessageTypes { get; set; }
        public int InboxRuleId { get; set; }
        public int? InboxSlackTemplateId { get; set; }
        public bool IsImmediate { get; set; }
        public bool IsSystem { get; set; }
        public string Name { get; set; }
        public int? RecurringScheduleId { get; set; }
        public bool SendEmail { get; set; }
        public bool SendSlack { get; set; }
    }
}
