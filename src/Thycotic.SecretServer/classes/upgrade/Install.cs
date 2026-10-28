using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Upgrade
{
    public class Install
    {
        public string ErrorMessage { get; set; }
        public bool LoginFail { get; set; }
        public bool UpgradeStartSuccess { get; set; }
    }
}
