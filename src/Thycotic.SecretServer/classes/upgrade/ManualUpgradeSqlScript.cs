using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Upgrade
{
    public class ManualUpgradeSqlScript
    {
        public string Details { get; set; }
        public bool HasScripts { get; set; }
        public bool LoginFail { get; set; }
        public string StatusMessage { get; set; }
        public bool Success { get; set; }
    }
}
