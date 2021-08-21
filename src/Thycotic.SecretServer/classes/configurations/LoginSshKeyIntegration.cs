using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class LoginSshKeyIntegration
    {
        public int AuthenticationMethod { get; set; }
        public bool Enable { get; set; }
        public int ExpirationInHours { get; set; }
        public bool KeyExpires { get; set; }
        public bool TwoFactorBypass { get; set; }
    }
}