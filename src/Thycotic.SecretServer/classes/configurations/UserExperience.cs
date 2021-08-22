using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class UserExperience
    {
        public int ApplicationLanguage { get; set; }
        public int DefaultDateFormat { get; set; }
        public int DefaultNewUserRoleId { get; set; }
        public int DefaultTimeFormat { get; set; }
        public bool ForceInactivityTimeout { get; set; }
        public int ForceInactivityTimeoutMinutes { get; set; }
        public bool RequireFolderForSecret { get; set; }
        public int SearchDelayMs { get; set; }
        public bool SecretPasswordHistoryRestrictionAll { get; set; }
        public int SecretPasswordHistoryRestrictionCount { get; set; }
        public int SecretViewIntervalMinutes { get; set; }
        public string ServerTimeZoneId { get; set; }
        public int UiInactivitySleepMinutes { get; set; }
    }
}