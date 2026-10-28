using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Secrets
{
    public class RpcDetail
    {
        public bool AutoChangeEnabled { get; set; }
        public PSObject AutoChangeSchedule { get; set; }
        public bool CanEnterNextPassword { get; set; }
        public bool DependencyPreRunValidationEnabled { get; set; }
        public string ExpireText { get; set; }
        public bool HasNextPassphrase { get; set; }
        public bool HasNextPassword { get; set; }
        public bool HasNextPrivateKey { get; set; }
        public bool IsValidForSshKeyRpc { get; set; }
        public PSObject PasswordStatus { get; set; }
        public int PasswordTypeId { get; set; }
        public string PasswordTypeName { get; set; }
        public int? PasswordTypeWebScriptId { get; set; }
        public int? PrivilegedAccountSecretId { get; set; }
        public string PrivilegedAccountSecretName { get; set; }
        public PSObject[] ResetSecrets { get; set; }
    }
}
