using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.InboxRules
{
    public class Condition
    {
        public string DisplayValue { get; set; }
        public int InboxDataId { get; set; }
        public string InboxDataName { get; set; }
        public string InboxDataType { get; set; }
        public int InboxRuleConditionId { get; set; }
        public int InboxRuleId { get; set; }
        public string InboxRuleOperand { get; set; }
        public bool? ValueBool { get; set; }
        public DateTime? ValueDateTime { get; set; }
        public int? ValueInt { get; set; }
        public string ValueString { get; set; }
    }
}