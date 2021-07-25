using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class LocalUserPasswords
    {
        public bool AllowUsersToResetForgottenPasswords { get; set; }
        public bool EnableLocalUserPasswordExpiration { get; set; }
        public bool EnableMinimumPasswordAge { get; set; }
        public bool EnablePasswordHistory { get; set; }
        public int LocalUserPasswordExpirationDays { get; set; }
        public int LocalUserPasswordExpirationHours { get; set; }
        public int LocalUserPasswordExpirationMinutes { get; set; }
        public int MinimumPasswordAgeDays { get; set; }
        public int MinimumPasswordAgeHours { get; set; }
        public int MinimumPasswordAgeMinutes { get; set; }
        public int PasswordHistoryItems { get; set; }
        public int PasswordMinimumLength { get; set; }
        public bool PasswordRequireLowercase { get; set; }
        public bool PasswordRequireNumbers { get; set; }
        public bool PasswordRequireSymbols { get; set; }
        public bool PasswordRequireUppercase { get; set; }
    }
}