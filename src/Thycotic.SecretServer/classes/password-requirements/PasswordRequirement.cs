using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.PasswordRequirements
{
    public class PasswordRequirement
    {
        public PSObject AllowedCharacterSet { get; set; }
        public string Description { get; set; }
        public string Example { get; set; }
        public bool IsDefault { get; set; }
        public int MaxPasswordLength { get; set; }
        public int MinPasswordLength { get; set; }
        public string Name { get; set; }
        public object[] PasswordDictionaries { get; set; }
        public int PasswordRequirementId { get; set; }
        public object[] PasswordRequirementRules { get; set; }
        public bool PreventDictionaryWords { get; set; }
        public bool PreventSequentialPattern { get; set; }
        public bool PreventSpatialPattern { get; set; }
        public bool PreventUsername { get; set; }
        public int SecretUsage { get; set; }
        public string[] TypeUsage { get; set; }
    }
}
