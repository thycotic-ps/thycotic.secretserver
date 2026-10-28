using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretExtensions
{
    public class AutofillValue
    {
        public bool CheckInSecretOnLastLauncherClose { get; set; }
        public bool CloseLauncherOnCheckInSecret { get; set; }
        public string Password { get; set; }
        public string Username { get; set; }
        public bool UseSessionRecording { get; set; }
        public bool WebLauncherRequiresIncognitoMode { get; set; }
    }
}
