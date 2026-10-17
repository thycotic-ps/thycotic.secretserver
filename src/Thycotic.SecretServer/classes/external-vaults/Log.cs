using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.ExternalVaults
{
    public class Log
    {
        public string ExternalVaultDisplayName { get; set; }
        public int ExternalVaultId { get; set; }
        public string ExternalVaultName { get; set; }
        public int? ExternalVaultSecretId { get; set; }
        public string ExternalVaultSecretName { get; set; }
        public DateTime? LogDate { get; set; }
        public int LogLevel { get; set; }
        public string LogMessage { get; set; }
    }
}
