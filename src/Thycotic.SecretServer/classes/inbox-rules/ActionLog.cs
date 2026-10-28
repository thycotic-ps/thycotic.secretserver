using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.InboxRules
{
    public class ActionLog
    {
        public string ActionType { get; set; }
        public string DisplayName { get; set; }
        public string InboxRuleActionStatus { get; set; }
        public DateTime? StatusDate { get; set; }
        public string StatusDescription { get; set; }
        public int? UserId { get; set; }
    }
}
