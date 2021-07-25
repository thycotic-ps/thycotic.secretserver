using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class General
    {
        public ApplicationSettings ApplicationSettings { get; set; }
        public EmailSettings Email { get; set; }
        public Folders Folders { get; set; }
        public LauncherSettings LauncherSettings { get; set; }
        public LocalUserPasswords LocalUserPasswords { get; set; }
        public PermissionOptions PermissionOptions { get; set; }
        public ProtocolHandlerSettings ProtocolHandlerSettings { get; set; }
        public UserExperience UserExperience { get; set; }
        public UserInterface UserInterface { get; set; }
    }
}