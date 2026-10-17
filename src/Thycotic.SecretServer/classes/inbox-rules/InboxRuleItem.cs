using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.InboxRules
{
    public class InboxRuleItem
    {
        public bool Active { get; set; }
        public bool? CurrentUserSubscribed { get; set; }
        public bool Digest { get; set; }
        public int InboxRuleId { get; set; }
        public string InboxRuleName { get; set; }
        public bool IsSystem { get; set; }
        public string[] NotificationTypes { get; set; }
        public int UsageCount { get; set; }
    }
}
