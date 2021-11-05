using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Rpc
{
    public class PasswordType
    {
        public bool Active { get; set; }
        public bool CanEdit { get; set; }
        public int CustomPort { get; set; }
        public string ExitCommand { get; set; }
        public PasswordTypeField[] Fields { get; set; }
        public bool HasCommands { get; set; }
        public bool HasLDAPSettings { get; set; }
        public string HeartbeatScriptArgs { get; set; }
        public int HeartbeatScriptId { get; set; }
        public bool IgnoreSSL { get; set; }
        public bool IsWeb { get; set; }
        public int LdapConnectionSettingsId { get; set; }
        public string LineEnding { get; set; }
        public string MainframeConnectionString { get; set; }
        public string Name { get; set; }
        public string OdbcConnectionString { get; set; }
        public int PasswordTypeId { get; set; }
        public string RpcScriptArgs { get; set; }
        public int RpcScriptId { get; set; }
        public string RunnerType { get; set; }
        public int ScanItemTemplateId { get; set; }
        public string TypeName { get; set; }
        public bool UseSSL { get; set; }
        public bool UseUsernameAndPassword { get; set; }
        public bool ValidForTakeover { get; set; }
        public string WindowsCustomPorts { get; set; }
    }
}
