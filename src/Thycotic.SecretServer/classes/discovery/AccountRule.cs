using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class AccountRule
    {
        public bool AccountAlerts { get; set; }
        public string AccountNameContains { get; set; }
        public bool ActionCreateSecrets { get; set; }
        public string ComputerNameContains { get; set; }
        public string CurrentPassphrase { get; set; }
        public string CurrentPassword { get; set; }
        public string CurrentPrivateKey { get; set; }
        public int? DiscoverySourceId { get; set; }
        public string DiscoverySourceName { get; set; }
        public object[] FilterFields { get; set; }
        public int? FolderId { get; set; }
        public string FolderName { get; set; }
        public bool ImportOnlyPolledLastScan { get; set; }
        public bool IncludeChildOUs { get; set; }
        public bool IsActive { get; set; }
        public string MatchingCondition { get; set; }
        public string NewPassword { get; set; }
        public string OperatingSystemContains { get; set; }
        public int? OrganizationUnitId { get; set; }
        public string OrganizationUnitName { get; set; }
        public object[] PasswordChangingPrivilegedAccountSecretIds { get; set; }
        public string PasswordChangingType { get; set; }
        public string PasswordOption { get; set; }
        public string RuleDescription { get; set; }
        public int RuleId { get; set; }
        public string RuleName { get; set; }
        public int ScanTemplateId { get; set; }
        public string ScanTemplateName { get; set; }
        public string SecretNamePattern { get; set; }
        public string SecretPermissions { get; set; }
        public int? SecretTemplateId { get; set; }
        public string SecretTemplateName { get; set; }
        public int SiteId { get; set; }
        public object[] SubscribedSpecificGroups { get; set; }
        public string SubscriberType { get; set; }
        public string TakeOverAccountType { get; set; }
        public int? TakeOverPasswordTypeId { get; set; }
        public object[] TakeoverSecretIds { get; set; }
        public int TakeOverThreshold { get; set; }
    }
}
