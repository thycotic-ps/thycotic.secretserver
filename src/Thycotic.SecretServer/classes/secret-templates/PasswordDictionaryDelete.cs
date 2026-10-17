using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretTemplates
{
    public class PasswordDictionaryDelete
    {
        public string[] InUsePasswordRequirements { get; set; }
        public bool IsDeleted { get; set; }
    }
}
