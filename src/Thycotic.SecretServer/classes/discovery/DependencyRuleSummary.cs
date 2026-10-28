using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class DependencyRuleSummary
    {
        public int DependencyTemplateId { get; set; }
        public string DependencyTemplateName { get; set; }
        public int? DiscoverySourceId { get; set; }
        public string DiscoverySourceName { get; set; }
        public bool IsActive { get; set; }
        public int RuleId { get; set; }
        public string RuleName { get; set; }
        public int ScanTemplateId { get; set; }
        public string ScanTemplateName { get; set; }
        public int SortOrder { get; set; }
    }
}
