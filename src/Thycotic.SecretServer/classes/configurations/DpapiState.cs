using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class DpapiState
    {
        public string ConfigFilePath { get; set; }
        public bool IsDpapiEncrypted { get; set; }
        public bool IsHsmEncrypted { get; set; }
    }
}
