using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class Login
    {
        public bool AllowAutoComplete { get; set; }
        public bool AllowRememberMe { get; set; }
        public bool CacheADCredentials { get; set; }
        public string DefaultLoginDomain { get; set; }
        public int EnableDomainSelector { get; set; }
        public bool EnableLoginFailureCAPTCHA { get; set; }
        public int MaxConcurrentLoginsPerUser { get; set; }
        public int MaximumLoginFailures { get; set; }
        public int MaxLoginFailuresBeforeCAPTCHA { get; set; }
        public int RememberMeTimeOutMinutes { get; set; }
        public LoginSshKeyIntegration SshKeyIntegration { get; set; } // object (ConfigurationLoginSshKeyIntegrationModel)
        public LoginTwoFactor twoFactor { get; set; } //object (ConfigurationLoginTwoFactorModel)
        public int UserLockoutTimeMinutes { get; set; }
        public bool VisualEncryptedKeyboardEnabled { get; set; }
        public bool VisualEncryptedKeyboardRequired { get; set; }
    }
}