using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretServerSettings
{
    public class ExportResult
    {
        public string ExportedSecretSettingsFileText { get; set; }
        public string FileName { get; set; }
        public string FileType { get; set; }
        public PSObject SecretServerSettings { get; set; }
    }
}
