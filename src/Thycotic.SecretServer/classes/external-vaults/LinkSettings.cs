using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.ExternalVaults
{
    public class LinkSettings
    {
        public string ActionableErrorMessage { get; set; }
        public PSObject AwsSettingsModel { get; set; }
        public PSObject AzureSettingsModel { get; set; }
        public string DefaultExternalName { get; set; }
        public PSObject GoogleSettingsModel { get; set; }
        public PSObject HashiCorpSettingsModel { get; set; }
        public int[] PasswordTypeIds { get; set; }
    }
}
