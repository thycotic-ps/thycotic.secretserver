using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class ConfigurationUserExperience
    {
        public int ApplicationLanguage { get; set; }
        public bool ApprovalAllowApproverChangeRequestTime { get; set; }
        public bool ApprovalAllowCustomDuration { get; set; }
        public int[] ApprovalAllowedMinuteDurations { get; set; }
        public int? ApprovalMaxRequestMinutes { get; set; }
        public int CheckoutNotificationThreshold { get; set; }
        public int DefaultDateFormat { get; set; }
        public int? DefaultNewUserRoleId { get; set; }
        public int DefaultTimeFormat { get; set; }
        public bool DisableLegacyBookmarkPages { get; set; }
        public bool EnableIconGathering { get; set; }
        public bool EnableRequestForceCheckout { get; set; }
        public bool EnableSecretCheckOutExtension { get; set; }
        public bool ForceInactivityTimeout { get; set; }
        public int ForceInactivityTimeoutMinutes { get; set; }
        public bool IncludeSessionInfoOnAllSecretAudits { get; set; }
        public int? MaxCheckOutExtensionInMinutes { get; set; }
        public int PasswordMaskTimeout { get; set; }
        public bool RequireFolderForSecret { get; set; }
        public int? SearchDelayMs { get; set; }
        public int SecretCommentIntervalMinutes { get; set; }
        public int SecretPasswordDisplayedIntervalMinutes { get; set; }
        public bool SecretPasswordHistoryRestrictionAll { get; set; }
        public int? SecretPasswordHistoryRestrictionCount { get; set; }
        public int SecretViewIntervalMinutes { get; set; }
        public bool SeparateCheckoutAndCommentAction { get; set; }
        public bool SeparateSecretAuditComment { get; set; }
        public string ServerTimeZoneId { get; set; }
        public bool ShowSecretIcons { get; set; }
        public int UiInactivitySleepMinutes { get; set; }
    }
}
