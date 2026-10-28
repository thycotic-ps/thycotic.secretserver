using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.InboxRules
{
    public class Subscriber
    {
        public string DisplayName { get; set; }
        public int DomainId { get; set; }
        public string DomainName { get; set; }
        public string EmailAddress { get; set; }
        public int? GroupId { get; set; }
        public int? InboxRuleAdditionalEmailId { get; set; }
        public int? InboxRuleSubscribersId { get; set; }
        public bool IsGroup { get; set; }
        public bool Subscribed { get; set; }
    }
}
