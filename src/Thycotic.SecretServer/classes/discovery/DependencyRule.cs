using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class DependencyRule
    {
        public int DiscoverySourceId { get; set; }
        public string DiscoverySourceName { get; set; }
        public bool IsActive { get; set; }
        public int? OrganizationUnitId { get; set; }
        public string OrganizationUnitName { get; set; }
        public int? PrivilegedAccountSecretId { get; set; }
        public string PrivilegedAccountSecretName { get; set; }
        public bool RestartServices { get; set; }
        public int RuleId { get; set; }
        public string RuleName { get; set; }
        public int ScanTemplateId { get; set; }
        public string ScanTemplateName { get; set; }
        public int SecretDependencyTemplateId { get; set; }
        public string SecretDependencyTemplateName { get; set; }
        public int? SiteId { get; set; }
    }
}
