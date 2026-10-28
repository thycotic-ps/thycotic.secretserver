using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretServerSettings
{
    public class Settings
    {
        public object[] AdvancedSettings { get; set; }
        public PSObject ApplicationSettings { get; set; }
        public object[] ConfigurationEmailMessageHeaders { get; set; }
        public string ConfigurationVersion { get; set; }
        public PSObject Email { get; set; }
        public bool EnableOidcAuth { get; set; }
        public string ExternalInstanceId { get; set; }
        public PSObject FolderSettings { get; set; }
        public PSObject LauncherSettings { get; set; }
        public object[] Licenses { get; set; }
        public PSObject LocalUserPasswords { get; set; }
        public PSObject Login { get; set; }
        public PSObject PermissionOptions { get; set; }
        public PSObject ProtocolHandlerSettings { get; set; }
        public PSObject Saml { get; set; }
        public PSObject Security { get; set; }
        public PSObject SessionRecording { get; set; }
        public PSObject SshCommands { get; set; }
        public PSObject TicketSystem { get; set; }
        public PSObject UserExperience { get; set; }
        public PSObject UserInterface { get; set; }
    }
}
