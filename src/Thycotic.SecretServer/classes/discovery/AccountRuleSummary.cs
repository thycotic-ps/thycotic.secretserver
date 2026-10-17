using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class AccountRuleSummary
    {
        public int? DiscoverySourceId { get; set; }
        public string DiscoverySourceName { get; set; }
        public int? FolderId { get; set; }
        public string FolderName { get; set; }
        public bool IsActive { get; set; }
        public string RuleAction { get; set; }
        public string RuleDescription { get; set; }
        public int RuleId { get; set; }
        public string RuleName { get; set; }
        public string RuleSummary { get; set; }
        public int ScanTemplateId { get; set; }
        public string ScanTemplateName { get; set; }
        public int? SecretTemplateId { get; set; }
        public string SecretTemplateName { get; set; }
        public int SortOrder { get; set; }
        public int TakeOverThreshold { get; set; }
    }
}
