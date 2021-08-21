using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class LoginTwoFactor
    {
        public bool AllowTwoFactorRememberMe { get; set; }
        public LoginDuo Duo { get; set; }
        public LoginOpenIdConnect OpenIdConnect { get; set; }
        public LoginRadius Radius { get; set; }
        public bool RequireTwoFactorForWebLogin { get; set; }
        public bool RequireTwoFactorForWebServices { get; set; }
        public int TwoFactorRememberMeTimeOutDays { get; set; }
    }
}